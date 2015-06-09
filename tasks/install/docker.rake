desc "Install Docker"
task :docker do |t|
  info t.name + ": started"
  info t.name + ": running Docker install script"
  runcmd 'wget -qO- https://get.docker.com/ | sh'
  info t.name + ": creating Docker data directories"
  FileUtils.mkdir_p CONFIG[:docker][:storage][:local]
  FileUtils.mkdir_p CONFIG[:docker][:storage][:repl]
  info t.name + ": finished"
end