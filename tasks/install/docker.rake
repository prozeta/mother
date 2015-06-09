desc "Install Docker"
task :docker do |t|
  info t.name + ": started"
  runcmd 'wget -qO- https://get.docker.com/ | sh'
  FileUtils.mkdir_p CONFIG[:docker][:storage][:local]
  FileUtils.mkdir_p CONFIG[:docker][:storage][:repl]
  info t.name + ": finished"
end