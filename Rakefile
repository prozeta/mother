require 'yaml'
require_relative 'lib/mixins.rb'
import 'lib/rake_methods.rb'
CONFIG = YAML.load_file('CONFIG.yaml')

if Process.uid != 0
  puts "Error: you have to be root!".red
  exit 1
end

task :default => [ :help ]
desc "This help"
task :help do
  puts 'Help'
end

desc "Run dist-upgrade"
task :upgrade_system => [ :update_repos ]
task :upgrade_system do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade'
end

namespace :install do
  Dir['tasks/install/*.rake'].each do |file|
    import file
  end
end

