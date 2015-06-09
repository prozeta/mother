desc "Install VRRPd"
task :vrrpd do
  info "installing VRRPd"
  Rake::Task["clean:vrrpd"].execute
  runcmd 'git clone https://github.com/fredbcode/Vrrpd.git /tmp/vrrp'
  runcmd 'cd /tmp/vrrp; make clean; make'
  FileUtils.cp '/tmp/vrrp/vrrpd', '/usr/local/bin/vrrpd'
  FileUtils.cp '/tmp/vrrp/atropos', '/usr/local/bin/atropos'
  Rake::Task["clean:vrrpd"].execute
  info "VRRPd installed"
end