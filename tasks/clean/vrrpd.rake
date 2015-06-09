task :vrrpd do |t|
  if File.exists? '/tmp/vrrp'
    FileUtils.rm_r '/tmp/vrrp'
    FileUtils.rmdir '/tmp/vrrp'
  end
  info t.name + ": finished"
end