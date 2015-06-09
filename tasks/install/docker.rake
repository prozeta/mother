desc "Install Docker"
task :docker do |t|
  info t.name + ": started"
  runcmd 'wget -qO- https://get.docker.com/ | sh'
  runcmd 'stop docker || true'
  runcmd '/etc/init.d/docker stop || true'
  info t.name + ": finished"
end