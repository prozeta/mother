desc "Install Maestro"
task :maestro do
  runcmd 'wget -q https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O/tmp/get-pip.py'
  runcmd 'python /tmp/get-pip.py'
  FileUtils.rm_f '/tmp/get-pip.py'
  FileUtils.rm_r '/tmp/pip_build_root'
  runcmd 'pip install -q --upgrade git+git://github.com/signalfuse/maestro-ng'
end