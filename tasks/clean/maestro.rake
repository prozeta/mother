desc "Clean Maestro build artifacts"
task :maestro do |t|
  task_begin t.name
  info t.name + ": removing PIP installer"
  FileUtils.rm_f '/tmp/get-pip.py'
  task_end t.name
end