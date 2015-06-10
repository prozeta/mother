class Drbd

  attr_reader :pri_ip
  attr_reader :pri_bd
  attr_reader :sec_ip
  attr_reader :sec_bd
  attr_reader :drbd_dev

  def initialize
     @pri_ip = CONFIG[:net][:repl][:ip_pri].split('/')[0]
     @pri_bd = CONFIG[:drbd][:pri]
     @sec_ip = CONFIG[:net][:repl][:ip_sec].split('/')[0]
     @sec_bd = CONFIG[:drbd][:sec]
     @drbd_dev = CONFIG[:drbd][:dev]
  end

  def conf_globals
    "global { usage-count yes; }\ncommon { net { protocol C; } }\n"
  end

  def conf_r0
    nodes = String.new
    nodes += self.node('mother1', self.drbd_dev, self.pri_bd, self.pri_ip)
    nodes += self.node('mother2', self.drbd_dev, self.sec_bd, self.sec_ip)
    "resource r0 {\n" + nodes + "}\n"
  end

  def node (name, device, disk, address)
    "  on #{name} { device #{device}; disk #{disk}; address #{address}:7789; meta-disk internal; }\n"
  end

  def write
    File.open("/etc/drbd.d/global_common.conf", "w")  { |f| f << self.conf_globals }
    File.open("/etc/drbd.d/r0.conf", "w")             { |f| f << self.conf_r0 }
  end
end