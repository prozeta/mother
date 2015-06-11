desc "Install DNS utils (nsupdate)"
task :dns do |t|
  task_begin t.name
  deb_install 'dnsutils'
  task_end t.name
end
