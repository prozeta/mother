desc "Install Maestro"
task :maestro do |t|
  task_begin
  info t.name + ": started"
  info t.name + ": downloading PIP installer"
  runcmd 'wget -q https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O/tmp/get-pip.py'
  info t.name + ": installing PIP"
  runcmd 'python /tmp/get-pip.py'
  info t.name + ": installing Maestro"
  runcmd 'pip install -q --upgrade git+git://github.com/signalfuse/maestro-ng'
  Rake::Task["clean:maestro"].execute
  task_end
end