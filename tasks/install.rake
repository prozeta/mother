desc "Install all needed software"
task :install do |t|
  task_begin t.name
  Rake::Task["install:dhcp"].invoke
  Rake::Task["install:dns"].invoke
  Rake::Task["install:docker"].invoke
  # Rake::Task["install:haproxy"].invoke
  Rake::Task["install:maestro"].invoke
  Rake::Task["install:vrrpd"].invoke
  task_end t.name
end