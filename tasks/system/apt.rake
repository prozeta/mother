desc "Update APT repositories"
task :update_apt do |t|
  info t.name + ": started"
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy update'
  info t.name + ": finished"
end

desc "Run dist-upgrade"
task :upgrade => [ :update_apt ]
task :upgrade do |t|
  info t.name + ": started"
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy dist-upgrade'
  info t.name + ": finished"
end