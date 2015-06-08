import 'rake_methods'
Dir['tasks/*.rake'].each { |file| import file }

task :default => [ :help ]

task :help do
  puts 'Help'
end

task :upgrade_system => [ :update_repos ]
task :upgrade_system do
  runcmd :apt, 'dist-upgrade'
end

task :update_repos do
  runcmd :apt, 'update'
end

