desc "Do it all!"
task :all => ["install"]
task :all do |t|
  info t.name + ": started"
  Rake::Task["system:prepare"].invoke
  Rake::Task["install"].invoke
  Rake::Task["config"].invoke
  info t.name + ": finished"
end