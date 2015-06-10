desc "Configure all needed software"
task :config do |t|
  info t.name + ": started"
  Rake::Task["config:drbd"].invoke
  Rake::Task["config:docker"].invoke
  Rake::Task["config:maestro"].invoke
  info t.name + ": finished"
end