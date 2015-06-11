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
      ( ipaddr, cidr ) = CONFIG[:net][:repl][:ip_pri].split('/')
    end

    @slave_ifs = CONFIG[:net][:bonding][:slave_ifs]
    @bond_if = CONFIG[:net][:bonding][:if]
    @ip = ipaddr.to_s
    @mask = IPAddr.new('255.255.255.255').mask(cidr).to_s
  end

  def conf_bond
    "auto #{self.bond_if}\niface bond0 inet static\n\taddress #{self.ip}\n\tnetmask #{self.mask}\n\tslaves #{self.slave_ifs.join(' ')}\n\tbond_mode 4\n\tbond-lacp-rate 1\n\tbond_miimon 100\n\n"
  end

  def conf_eth
    out = String.new
    self.slave_ifs.each do |iface|
      out += "auto #{iface}\niface #{iface} inet manual\n\tbond-master #{self.bond_if}\n\n"
    end
    out
  end

  def write
    File.open("/etc/network/interfaces.d/#{self.bond_if}", "w") { |f| f << self.conf_eth + self.conf_bond }
  end

end