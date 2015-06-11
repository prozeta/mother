desc "Configure all needed software"
task :config do |t|
  task_begin t.name
  Rake::Task["config:drbd"].invoke
  Rake::Task["config:docker"].invoke
  Rake::Task["config:maestro"].invoke
  task_end t.name
end