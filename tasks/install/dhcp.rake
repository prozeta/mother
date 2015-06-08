desc "Install DHCP relay"
task :dhcp do
  deb_install 'isc-dhcp-relay'
end
