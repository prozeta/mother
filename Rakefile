require 'yaml'
import 'rake_methods.rb'
import 'mixins.rb'
Dir['tasks/*.rake'].each { |file| import file }
CONFIG = YAML.load_file('CONFIG.yaml')

{ puts "Error: you have to be root!"; exit 1; } if ! am_i_root?

task :default => [ :help ]
task :help do
  puts 'Help'
end

task :upgrade_system => [ :update_repos ]
task :upgrade_system do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade'
end

task :update_repos do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -y update'
end

