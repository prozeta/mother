desc "Install VRRPd"
task :vrrpd do |t|
  task_begin t.name
  Rake::Task["clean:vrrpd"].execute
  info t.name + ": downloading VRRPd"
  runcmd 'git clone https://github.com/fredbcode/Vrrpd.git /tmp/vrrp'
  info t.name + ": compiling VRRPd"
  runcmd 'cd /tmp/vrrp; make clean; make'
  info t.name + ": installing VRRPd"
  FileUtils.cp '/tmp/vrrp/vrrpd', '/usr/local/bin/vrrpd'
  FileUtils.cp '/tmp/vrrp/atropos', '/usr/local/bin/atropos'
  Rake::Task["clean:vrrpd"].execute
  task_end t.name
end