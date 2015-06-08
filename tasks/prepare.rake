task :prepare do
  deb_install "wget", "bridge-utils"
  deb_install "python-software-properties", "python-dev", "python-yaml"
end