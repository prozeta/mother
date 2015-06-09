class Bonding

  require 'ipadd'

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

  def conf
    "# created automatically by Project Mother
auto #{self.bond_if}
iface bond0 inet static
    address #{self.ip}
    netmask #{self.mask}
    slaves #{self.slave_ifs.join(' ')}
    bond_mode active-backup
    bond_miimon 100
    bond_downdelay 200
    bond_updelay 200"
  end

  def write
    File.open("/etc/network/interfaces.d/#{self.bond_if}", "w") { |f| f << self.conf }
  end

end