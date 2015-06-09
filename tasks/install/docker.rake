desc "Install Docker"
task :docker do
  runcmd 'wget -qO- https://get.docker.com/ | sh'
  runcmd 'stop docker || true'
  runcmd '/etc/init.d/docker stop || true'
end