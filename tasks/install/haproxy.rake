desc "Install HAProxy Daemon"
task :haproxy do |t|
  deb_install "haproxy"
  info t.name + ": HAProxy installed"
end