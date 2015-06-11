desc "Install DHCP relay"
task :dhcp do |t|
  task_begin t.name
  deb_install 'isc-dhcp-relay'
  task_end t.name
end
