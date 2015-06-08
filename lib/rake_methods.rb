def runcmd *args
  cmd = args.join(' ')
  begin
    system "bash -c '#{cmd}' >> /tmp/mother_cmds.log 2>&1"
  rescue Exception => e
    puts 'Failed: '.red + cmd
    puts e.message.yellow
  end
end

def deb_install *args
  pkgs = args.join(' ')
  begin
    system "bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install #{pkgs} >/tmp/mother_install.log 2>&1'"
  rescue Exception => e
    puts ('Not installed: ' + pkgs).red
    puts e.message.yellow
  end
end