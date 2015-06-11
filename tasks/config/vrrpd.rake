desc "Configure VRRPd"
task :vrrpd do |t|
  task_begin
  Vrrpd.new.write
  task_end
end