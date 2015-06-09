desc "Install VRRPd"
task :vrrpd do
  FileUtils.rm_r '/tmp/vrrp'
  FileUtils.rmdir '/tmp/vrrp'
  runcmd 'git clone https://github.com/fredbcode/Vrrpd.git /tmp/vrrp'
  runcmd 'cd /tmp/vrrp; make clean; make'
  FileUtils.cp '/tmp/vrrp/vrrpd', '/usr/local/bin/vrrpd'
  FileUtils.cp '/tmp/vrrp/atropos', '/usr/local/bin/atropos'
  FileUtils.rm_r '/tmp/vrrp'
  FileUtils.rmdir '/tmp/vrrp'
end