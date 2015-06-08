def runcmd *args
  cmd = args.join(' ')
  puts 'Running: ', cmd
  begin
    sh 'bash', '-c \'', cmd, '\''
    puts 'Finished: ', cmd
  rescue
    puts 'Failed: ', cmd
  end
end

def install *args
  pkgs = args.join(' ')
  puts 'Installing: ', pkgs
  begin
    sh 'DEBIAN_FRONTEND=noninteractive apt-get -qqy', pkgs
    puts 'Installed: ', pkgs
  rescue
    puts 'Not installed:', pkgs
  end
end

def am_i_root?
  Process.uid == 0 ? true : false
end