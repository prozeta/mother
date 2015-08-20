desc "Install Docker"
task :docker do |t|
  task_begin t.name
  info t.name + ": running Docker install script"
  runcmd 'wget -qO- https://get.docker.com/ | sh'
  info t.name + ": creating Docker data directories"
  FileUtils.mkdir_p CONFIG[:docker][:storage]
  FileUtils.mkdir_p CONFIG[:docker][:storage] + "/dns"
  FileUtils.mkdir_p CONFIG[:docker][:storage] + "/dhcp"
  FileUtils.mkdir_p CONFIG[:docker][:storage] + "/mysql"
  FileUtils.mkdir_p CONFIG[:docker][:storage] + "/puppetmaster"
  FileUtils.mkdir_p CONFIG[:docker][:storage] + "/puppetca"
  FileUtils.mkdir_p CONFIG[:docker][:storage] + "/foreman"
  task_end t.name
end