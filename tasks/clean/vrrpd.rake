desc "Clean VRRPd build artifacts"
task :vrrpd do |t|
  info t.name + ": started"
  if File.exists? '/tmp/vrrp'
    FileUtils.rm_rf '/tmp/vrrp'
  end
  info t.name + ": finished"
end