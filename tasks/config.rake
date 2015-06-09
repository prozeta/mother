desc "Configure all needed software"
task :config do |t|
  info t.name + ": started"
  Rake::Task["config:docker"].invoke
  info t.name + ": finished"
end