desc "Configure maestro service templates"
task :maestro => [ "install:maestro" ]
task :maestro do |t|
  info t.name + ": started"
  info t.name + ": finished"
end