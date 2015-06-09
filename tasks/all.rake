desc "Do it all!"
task :all => ["install"]
task :all do |t|
  info t.name + ": started"
  Rake::Task["install"].invoke
  Rake::Task["config"].invoke
  info t.name + ": finished"
end