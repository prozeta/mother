require 'yaml'
require_relative 'lib/mixins.rb'

Rake::TaskManager.record_task_metadata = true

desc "This help"
task :help do
  Rake::application.options.show_tasks = :tasks  # this solves sidewaysmilk problem
  Rake::application.options.show_task_pattern = //
  Rake::application.display_tasks_and_comments
end

import 'lib/rake_methods.rb'
CONFIG = YAML.load_file('CONFIG.yaml')

if Process.uid != 0
  puts "Error: you have to be root!".red
  exit 1
end

task :default => [ :help ]

desc "Update APT repositories"
task :update_repos do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy update'
end

desc "Run dist-upgrade"
task :upgrade_system => [ :update_repos ]
task :upgrade_system do
  runcmd 'DEBIAN_FRONTEND=noninteractive apt-get -qqy dist-upgrade'
end

namespace :install do
  Dir['tasks/install/*.rake'].each do |file|
    load file
  end
end

