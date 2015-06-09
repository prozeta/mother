desc "Install all needed software"
task :install do |t|
  info t.name + ": started"
  Rake::Task["install:dhcp"].execute
  Rake::Task["install:dns"].execute
  Rake::Task["install:drbd"].execute
  Rake::Task["install:docker"].execute
  Rake::Task["install:haproxy"].execute
  Rake::Task["install:mestro"].execute
  Rake::Task["install:vrrpd"].execute
  info t.name + ": finished"
end