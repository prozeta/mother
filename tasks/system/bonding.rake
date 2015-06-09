desc "Configure bonding interfaces"
task :bonding do |t|
  info t.name + ": started"
  require_relative '../../lib/bonding.rb'
  info t.name + ": creating bonding config"
  Bonding.new.write
  info t.name + ": starting bonding & setting up interfaces"
  runcmd 'ifdown --force ' + CONFIG[:net][:repl][:if]
  runcmd 'ifup ' + CONFIG[:net][:repl][:if]
  info t.name + ": finished"
end