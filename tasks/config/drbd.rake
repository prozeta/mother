desc "Configure DRBD"
task :drbd do |t|
  info t.name + ": started"
  require_relative '../../lib/drbd.rb'
  info t.name + ": Gerenating DRBD config files"
  Drbd.new.write
  info t.name + ": finished"
end