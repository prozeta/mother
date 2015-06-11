desc "Install DHCP relay"
task :dhcp do |t|
  info t.name + ": TASK BEGIN"
  deb_install 'isc-dhcp-relay'
  info t.name + ": TASK END"
end
