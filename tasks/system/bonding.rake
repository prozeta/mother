desc "Configure bonding interfaces"
task :bonding do |t|
  info t.name + ": started"
  require_relative '../../lib/bonding.rb'
  info t.name + ": creating bonding config"
  Bonding.new.write
  info t.name + ": starting bonding & setting up interfaces"
  runcmd 'ifdown --force ' + CONFIG[:net][:bonding][:if]
  CONFIG[:net][:bonding][:slave_ifs].each { |eth| runcmd 'ifdown --force ' + eth }
  sleep 2
  CONFIG[:net][:bonding][:slave_ifs].each { |eth| runcmd 'ifup ' + eth }
  sleep 1
  runcmd 'ifup ' + CONFIG[:net][:bonding][:if]
  info t.name + ": finished"
end