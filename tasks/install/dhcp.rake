desc "Install DHCP relay"
task :dhcp do |t|
  info t.name + ": started"
  deb_install 'isc-dhcp-relay'
  info t.name + ": finished"
end
