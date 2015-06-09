desc "Install needed utils"
task :prepare => [ "system:upgrade" ]
task :prepare do |t|
  info t.name + ": started"
  deb_install "wget", "bridge-utils", "ifenslave"
  deb_install "python-software-properties", "python-dev", "python-yaml"
  runcmd 'mkdir -p /etc/network/interfaces.d'
  runcmd 'grep source-directory /etc/network/interfaces || echo "source-directory /etc/network/interfaces.d" >> /etc/network/interfaces'
  info t.name + ": finished"
end