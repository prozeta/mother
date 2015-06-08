def runcmd *args
  cmd = args.join(' ')
  puts ('Running: ' + cmd).blue
  begin
    system "bash -c '#{cmd}'"
    puts ('Finished: ' + cmd).green
  rescue Exception => e
    puts ('Failed: ' + cmd).red
    puts e.message.red
  end
end

def deb_install *args
  pkgs = args.join(' ')
  puts ('Installing: ' + pkgs).blue
  begin
    system "bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -qqy install #{pkgs}'"
    puts ('Installed: ' + pkgs).green
  rescue Exception => e
    puts ('Not installed: ' + pkgs).red
    puts e.message.red
  end
end

def am_i_root?
  Process.uid == 0 ? true : false
end