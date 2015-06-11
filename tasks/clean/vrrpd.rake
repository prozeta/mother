desc "Clean VRRPd build artifacts"
task :vrrpd do |t|
  task_begin t.name
  if File.exists? '/tmp/vrrp'
    FileUtils.rm_rf '/tmp/vrrp'
  end
  task_end t.name
end