def cmdlog logline
  File.open("/tmp/mother_cmds.log", "a") { |f| f << Time.now.to_s + ": CMD " + logline }
end

def aptlog logline
  File.open("/tmp/mother_apt.log", "a") { |f| f << Time.now.to_s + ": APT " + logline }
end


def runcmd *args
  cmd = args.join(' ')
  begin
    cmdlog "start -> " + cmd
    system "bash -c '#{cmd}' >> /tmp/mother_cmds.log 2>&1"
    cmdlog "success -> " + cmd
    if $? > 0
      err "Failed running command: " + cmd
      cmdlog "fail -> " + cmd
      warn "Check /tmp/mother_cmds.log for output"
      exit 1
    end
  rescue Exception => e
    err "Failed running command: " + cmd
    err e.message
    cmdlog "fail -> " + cmd
    cmdlog "exception -> " + e.message
  end
end

def deb_install *args
  pkgs = args.join(' ')
  begin
    aptlog "install -> " + pkgs
    system "bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install #{pkgs} >> /tmp/mother_apt.log 2>&1'"
    info "Installed DEBs: " + pkgs
    if $? > 0
      err 'DEB installation failed: ' + pkgs
      aptlog "fail -> " + pkgs
      warn "Check /tmp/mother_apt.log for output"
      exit 1
    end
  rescue Exception => e
    err 'DEB installation failed: ' + pkgs
    err e.message
    aptlog "fail -> " + pkgs
    aptlog "exception => " + e.message
  end
end
