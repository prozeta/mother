desc "Install all needed software"
task :install do |t|
  info t.name + ": started"
  Rake::Task["install:dhcp"].invoke
  Rake::Task["install:dns"].invoke
  Rake::Task["install:drbd"].invoke
  Rake::Task["install:docker"].invoke
  Rake::Task["install:haproxy"].invoke
  Rake::Task["install:maestro"].invoke
  Rake::Task["install:vrrpd"].invoke
  info t.name + ": finished"
end