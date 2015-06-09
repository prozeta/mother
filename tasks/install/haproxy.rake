desc "Install HAProxy Daemon"
task :haproxy do |t|
  info t.name + ": started"
  deb_install "haproxy"
  info t.name + ": finished"
end