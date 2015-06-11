desc "Install DNS utils (nsupdate)"
task :dns do |t|
  task_begin
  deb_install 'dnsutils'
  task_end
end
