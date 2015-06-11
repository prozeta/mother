desc "Install HAProxy Daemon"
task :haproxy do |t|
  task_begin t.name
  deb_install "haproxy"
  task_end t.name
end