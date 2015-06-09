class Bonding

  require 'ipaddr'

  attr_accessor :slave_ifs
  attr_accessor :bond_if
  attr_accessor :ip
  attr_accessor :mask


  def initialize
    if ENV["role"] == "sec"
      ( ipaddr, cidr ) = CONFIG[:net][:repl][:ip_sec].split('/')
    else
      ( ipaddr, cidr ) = CONFIG[:net][:repl][:ip_sec].split('/')
    end

    @slave_ifs = CONFIG[:net][:bonding][:slave_ifs]
    @bond_if = CONFIG[:net][:bonding][:if]
    @ip = ipaddr.to_s
    @mask = IPAddr.new('255.255.255.255').mask(cidr).to_s
  end

  def conf_bond
    "# created automatically by Project Mother
auto #{self.bond_if}
iface bond0 inet static
    address #{self.ip}
    netmask #{self.mask}
    slaves #{self.slave_ifs.join(' ')}
    bond_mode 4
    bond-lacp-rate 1
    bond_miimon 100\n\n"
  end

  def conf_eth
    out = ""
    self.slave_ifs.each do |iface|
      out += "# created automatically by Project Mother
auto #{iface}
iface #{iface} inet manual
    bond-master #{self.bond_if}\n\n"
    end
    out
  end

  def write
    File.open("/etc/network/interfaces.d/#{self.bond_if}", "w") { |f| f << self.conf_eth + self.conf_bond }
  end

end