desc "Install DRBD"
task :drbd do |t|
  task_begin
  deb_install 'drbd8-utils'
  task_end
end
