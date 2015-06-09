desc "Update APT repositories"
task :update_apt do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy update'
end

desc "Run dist-upgrade"
task :upgrade => [ :update_apt ]
task :upgrade do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy dist-upgrade'
end