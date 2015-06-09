desc "Configure bonding interfaces"
task :bonding do |t|
  info t.name + ": started"
  require_relative '../../lib/bonding.rb'
  info t.name + ": creating bonding config"
  Bonding.new.write
  info t.name + ": starting bonding & setting up interfaces"
  runcmd 'ifdown --force ' + CONFIG[:net][:bonding][:if]
  CONFIG[:net][:bonding][:ifs].each { |eth| runcmd 'ifdown --force ' + eth }
  CONFIG[:net][:bonding][:ifs].each { |eth| runcmd 'ifup ' + eth }
  runcmd 'ifup ' + CONFIG[:net][:bonding][:if]
  info t.name + ": finished"
end