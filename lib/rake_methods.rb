def cmdlog logline
  File.open("/tmp/mother_cmds.log", "a") { |f| f << Time.now.to_s + ": CMD " + logline + "\n" }
end

def aptlog logline
  File.open("/tmp/mother_apt.log", "a") { |f| f << Time.now.to_s + ": APT " + logline + "\n" }
end

def runcmd *args
  cmd = args.join(' ')
  begin
    cmdlog "start -> " + cmd
    if system "bash -c '#{cmd}' >> /tmp/mother_cmds.log 2>&1"
      cmdlog "success -> " + cmd
    else
      err "Failed running command: " + cmd
      cmdlog "fail -> " + cmd
      warn "Check /tmp/mother_cmds.log for output"
      exit! 1
    end
  rescue Exception => e
    err "Failed running command: " + cmd
    err e.message
    cmdlog "fail -> " + cmd
    cmdlog "exception -> " + e.message
    exit! 1
  end
end

def deb_install *args
  pkgs = args.join(' ')
  begin
    aptlog "install -> " + pkgs
    if system "bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -qy install #{pkgs} >> /tmp/mother_apt.log 2>&1'"
      aptlog "installed -> " + pkgs
    else
      err 'DEB installation failed: ' + pkgs
      aptlog "fail -> " + pkgs
      warn "Check /tmp/mother_apt.log for output"
      exit! 1
    end
  rescue Exception => e
    err 'DEB installation failed: ' + pkgs
    err e.message
    aptlog "fail -> " + pkgs
    aptlog "exception => " + e.message
    exit! 1
  end
end
