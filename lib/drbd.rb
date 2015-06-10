class Drbd

  attr_reader :ip_pri
  attr_reader :ip_sec
  attr_reader :disk
  attr_reader :device

  def initialize
     @ip_pri = CONFIG[:net][:repl][:ip_pri].split('/')[0]
     @ip_sec = CONFIG[:net][:repl][:ip_sec].split('/')[0]
     @disk = CONFIG[:drbd][:disk]
     @device = CONFIG[:drbd][:device]
  end

  def conf_globals
    "global { usage-count yes; }\ncommon { net { protocol C; } }\n"
  end

  def conf_r0
    nodes = self.node('mother1', self.ip_pri) + self.node('mother2', self.ip_sec)
    "resource r0 {\n" +
    "  disk #{self.disk};\n" +
    "  device #{self.device}\n" +
    "  meta-disk internal;\n" +
    "#{nodes}\n}"
  end

  def node (name, address)
    "  on #{name} { address #{address}:7789; }\n"
  end

  def write
    File.open("/etc/drbd.d/global_common.conf", "w")  { |f| f << self.conf_globals }
    File.open("/etc/drbd.d/r0.conf", "w")             { |f| f << self.conf_r0 }
  end
end