desc "Clean Maestro build artifacts"
task :maestro do |t|
  info t.name + ": started"
  info t.name + ": removing PIP installer"
  rm_f '/tmp/get-pip.py'
  info t.name + ": finished"
end