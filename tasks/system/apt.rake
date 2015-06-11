desc "Update APT repositories"
task :update_apt do |t|
  task_begin
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy update'
  task_end
end

desc "Run dist-upgrade"
task :upgrade => [ :update_apt ]
task :upgrade do |t|
  task_begin
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy dist-upgrade'
  task_end
end