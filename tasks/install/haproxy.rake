desc "Install HAProxy Daemon"
task :haproxy do |t|
  task_begin
  deb_install "haproxy"
  task_end
end