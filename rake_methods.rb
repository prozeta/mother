def runcmd *args
  cmd = args.join(' ')
  puts ('Running: ' + cmd).green
  begin
    system "bash -c '#{cmd}'"
  rescue Exception => e
    puts ('Failed: ' + cmd).red
    puts e.message.red
  end
end

def deb_install *args
  pkgs = args.join(' ')
  puts ('Installing: ' + pkgs).green
  begin
    system "bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -qqy install #{pkgs}'"
  rescue Exception => e
    puts ('Not installed: ' + pkgs).red
    puts e.message.red
  end
end

def am_i_root?
  Process.uid == 0 ? true : false
end