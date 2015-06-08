def runcmd *args
  cmd = args.join(' ')
  begin
    system "bash -c '#{cmd} >> /tmp/mother_install.log 2>&1'"
  rescue Exception => e
    puts 'Failed: '.red + cmd
    puts e.message.yellow
  end
end

def deb_install *args
  pkgs = args.join(' ')
  begin
    system "bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -qqy install #{pkgs}'"
  rescue Exception => e
    puts ('Not installed: ' + pkgs).red
    puts e.message.yellow
  end
end

def am_i_root?
  Process.uid == 0 ? true : false
end