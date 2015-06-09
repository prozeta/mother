require 'yaml'
require_relative 'lib/mixins.rb'

Rake::TaskManager.record_task_metadata = true

desc "This help"
task :help do
  Rake::application.options.show_tasks = :tasks
  Rake::application.options.show_task_pattern = //
  Rake::application.display_tasks_and_comments
end

import 'lib/rake_methods.rb'
CONFIG = YAML.load_file('CONFIG.yaml')

if ! am_i_root?
  puts "FATAL: you have to be root!".red
  exit 1
end

if CONFIG[:ha] && ENV["role"] !~ /^(pri|sec)$/
  puts "ERROR: you have to specify the role of this host for HA mode.".yellow
  puts "\ta) rake [task] role=(pri|sec)"
  puts "\tb) export role=(pri|sec)"
  exit 1
elsif CONFIG[:ha]

else
  puts "FATAL: unknown HA mode!"
  exit 1
end

task :default => [ :help ]

namespace :system do
  Dir['tasks/system/*.rake'].each do |file|
    load file
  end
end

namespace :install do
  Dir['tasks/install/*.rake'].each do |file|
    load file
  end
end

namespace :ha do
  Dir['tasks/ha/*.rake'].each do |file|
    load file
  end
end

