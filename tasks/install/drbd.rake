desc "Install DRBD"
task :drbd do |t|
  task_begin t.name
  deb_install 'drbd8-utils'
  task_end t.name
end
