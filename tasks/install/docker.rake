desc "Install Docker"
task :docker do |t|
  info t.name + ": started"
  runcmd 'wget -qO- https://get.docker.com/ | sh'
  info t.name + ": finished"
end