desc "Do it all!"
task :all do |t|
  task_begin t.name
  Rake::Task["system:prepare"].invoke
  Rake::Task["install"].invoke
  Rake::Task["config"].invoke
  task_end t.name
end