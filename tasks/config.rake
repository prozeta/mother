desc "Configure all needed software"
task :config do |t|
  task_begin t.name
  Rake::Task["config:docker"].invoke
  Rake::Task["config:maestro"].invoke
  Rake::Task["config:vrrpd"].invoke
  task_end t.name
end