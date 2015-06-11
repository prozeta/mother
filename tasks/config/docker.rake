desc "Configure Docker"
task :docker do |t|
  task_begin t.name
  info t.name + ": stopping Docker"
  runcmd 'stop docker || true'
  runcmd '/etc/init.d/docker stop || true'
  info t.name + ": cleaning old Docker bridge network config"
  runcmd 'ip l s dev docker0 down || true'
  runcmd 'brctl delbr docker0 || true'
  info t.name + ": cleaning old Docker netfilter rules"
  runcmd '( iptables-save -t nat | grep -i \\\-A | grep -i docker | sed s/-A/-D/ | xargs -L1 -I{} iptables -t nat {} ) 2>/dev/null || true'
  runcmd '( iptables-save -t filter | grep -i \\\-A | grep -i docker | sed s/-A/-D/ | xargs -L1 -I{} iptables -t filter {} ) 2>/dev/null || true'
  info t.name + ": setting DOCKER_OPTS in /etc/default/docker"
  File.write '/etc/default/docker', "DOCKER_OPTS=\"--bip #{CONFIG[:docker][:br_ip]} --dns #{CONFIG[:docker][:dns]}\""
  info t.name + ": starting Docker service"
  runcmd 'start docker'
  runcmd 'ip l s dev docker0 up'
  info t.name + ": finished"
  task_end t.name
end