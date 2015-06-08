desc "Install needed utils"
task :prepare => [ :upgrade_system ] do
  deb_install "wget", "bridge-utils", "sipcalc"
  deb_install "python-software-properties", "python-dev", "python-yaml"
end