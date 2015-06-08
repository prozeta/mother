desc "Update APT repositories"
task :update_repos do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy update'
end

desc "Run dist-upgrade"
task :upgrade_system => [ :update_repos ]
task :upgrade_system do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy dist-upgrade'
end