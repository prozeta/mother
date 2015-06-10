desc "Configure DRBD"
task :drbd do |t|
  info t.name + ": started"
  require_relative '../../lib/drbd.rb'
  info t.name + ": Gerenating DRBD config files"
  Drbd.new.write
  info t.name + ": Starting DRBD resources"
  runcmd 'drbdadm role r0 || drbdadm create-md r0'
  if is_pri?
    info t.name + ": This node is primary, switching DRBD resources acordingly"
    runcmd 'drbdadm primary --force all'
    info t.name + ": Formatting #{CONFIG[:drbd][:device]} if there's no FS"
    runcmd 'grep -q ' + CONFIG[:drbd][:device] + ' <(blkid) || mkfs.ext4 ' + CONFIG[:drbd][:device]
    info t.name + ": Adding to /etc/fstab if missing."
    runcmd 'grep -q ' + CONFIG[:drbd][:device] + ' /etc/fstab || echo -e "' + CONFIG[:drbd][:device] + '\t' + CONFIG[:docker][:storage][:repl] + '\t\text4\tdefaults,ro\t0\t0" >> /etc/fstab'
    info t.name + ": Mounting #{CONFIG[:drbd][:device]} into #{CONFIG[:docker][:storage][:repl]} (rw)"
    runcmd 'grep -q "' + CONFIG[:docker][:storage][:repl] + '" /proc/mounts || mount -o rw ' + CONFIG[:docker][:storage][:repl]
  else
    info t.name + ": Adding to /etc/fstab if missing."
    runcmd 'grep -q ' + CONFIG[:drbd][:device] + ' /etc/fstab || echo -e "' + CONFIG[:drbd][:device] + '\t' + CONFIG[:docker][:storage][:repl] + '\t\text4\tdefaults,ro\t0\t0" >> /etc/fstab'
    info t.name + ": Mounting #{CONFIG[:drbd][:device]} into #{CONFIG[:docker][:storage][:repl]} (ro)"
    runcmd 'grep -q "' + CONFIG[:docker][:storage][:repl] + '" /proc/mounts || mount ' + CONFIG[:docker][:storage][:repl]
  end
  info t.name + ": finished"
end