desc "Install DNS utils (nsupdate)"
task :dns do |t|
  info t.name + ": started"
  deb_install 'dnsutils'
  info t.name + ": finished"
end
