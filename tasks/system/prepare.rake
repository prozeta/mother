desc "Install needed utils"
task :prepare => [ "system:upgrade" ]
task :prepare do |t|
  info t.name + ": started"
  deb_install "wget", "bridge-utils", "ifenslave"
  deb_install "python-software-properties", "python-dev", "python-yaml"
  info t.name + ": finished"
end