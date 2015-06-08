desc "Install DNS utils (nsupdate)"
task :dns do
  deb_install 'dnsutils'
end
