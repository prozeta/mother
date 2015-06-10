desc "Configure DRBD"
task :drbd do |t|
  info t.name + ": started"
  require_relative '../../lib/drbd.rb'
  info t.name + ": Gerenating DRBD config files"
  Drbd.new.write
  info t.name + ": Starting DRBD resources"
  runcmd 'drbdadm create-md all'
  if is_pri?
    info t.name + ": This node is primary, switching DRBD resources"
    runcmd 'drbdadm primary --force all'
    runcmd 'grep -q ' + CONFIG[:drbd][:device] + ' <(blkid) || mkfs.ext3 ' + CONFIG[:drbd][:device]
    runcmd 'grep -q ' + CONFIG[:drbd][:device] + ' /etc/fstab || echo -e "/dev/drbd1\t' + CONFIG[:drbd][:device] + '\t' + CONFIG[:docker][:storage][:repl] + '\t\text4\tdefaults,ro\t0\t0" > /etc/fstab'
    runcmd 'mount -o remount,rw ' + CONFIG[:docker][:storage][:repl]
  end
  info t.name + ": finished"
end