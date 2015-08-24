require 'yaml'
require_relative 'lib/mixins.rb'
require_relative 'lib/helpers.rb'
require_relative 'lib/etcd.rb'
require_relative 'lib/maestro.rb'
require_relative 'lib/maestro/stage1.rb'
require_relative 'lib/maestro/stage2.rb'
require_relative 'lib/maestro/stage3.rb'

Rake::application.init("mother")
Rake::TaskManager.record_task_metadata = true

##
## HELP
##
desc "This help"
task :help do
  Rake::application.options.show_tasks = :tasks
  Rake::application.options.show_task_pattern = //
  Rake::application.display_tasks_and_comments
end

##
## RAKE HELPER METHODS
##
import 'lib/rake_methods.rb'

##
## CONFIG LOAD
##
CONFIG = YAML.load_file('/etc/mother.yaml')

##
## UID CHECK (must be root)
##
if ! am_i_root?
  err "You have to be root!"
  exit 1
end

##
## CONFIG CHECK (mandatory variables)
##
if CONFIG[:ha] && ENV["role"] !~ /^(pri|sec)$/
  err "You have to specify the role of this host for HA mode."
  warn "\ta) mother [task] role=(pri|sec)"
  warn "\tb) export role=(pri|sec)"
  exit 1
end

##
## TASK DEFINITIONS
##
task :default => [ :help ]
Dir['tasks/*.rake'].each do |file|
  load file
end
namespace :clean do
  Dir['tasks/clean/*.rake'].each do |file|
    load file
  end
end
namespace :system do
  Dir['tasks/system/*.rake'].each do |file|
    load file
  end
end
namespace :config do
  Dir['tasks/config/*.rake'].each do |file|
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