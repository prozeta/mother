desc "Configure VRRPd"
task :vrrpd do |t|
  info t.name + ": TASK BEGIN"
  Vrrpd.new.write
  info t.name + ": TASK END"
end