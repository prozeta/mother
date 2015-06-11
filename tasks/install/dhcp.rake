desc "Install DHCP relay"
task :dhcp do |t|
  task_begin
  deb_install 'isc-dhcp-relay'
  task_end
end
