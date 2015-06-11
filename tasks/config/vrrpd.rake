desc "Configure VRRPd"
task :vrrpd do |t|
  task_begin t.name
  Vrrpd.new.write
  task_end t.name
end