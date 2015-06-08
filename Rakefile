require 'yaml'
require_relative 'mixins.rb'
import 'rake_methods.rb'
Dir['tasks/*.rake'].each { |file| import file }
CONFIG = YAML.load_file('CONFIG.yaml')

if ! Process.uid != 0
  puts "Error: you have to be root!".red
  exit 1
end

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

