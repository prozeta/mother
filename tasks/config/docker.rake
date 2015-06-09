desc "Configure Docker"
task :docker do |t|
  info t.name + ": started"
  info t.name + ": cleaning old Docker bridge network config"
  runcmd 'ip l s dev docker0 down || true'
  runcmd 'brctl delbr docker0 || true'
  runcmd '( iptables-save -t nat | grep -i \\\-A | grep -i docker | sed s/-A/-D/ | xargs -L1 -I{} iptables -t nat {} ) 2>/dev/null || true'
  runcmd '( iptables-save -t filter | grep -i \\\-A | grep -i docker | sed s/-A/-D/ | xargs -L1 -I{} iptables -t filter {} ) 2>/dev/null || true'
  info t.name + ": setting DOCKER_OPTS"
  docker_opts = "DOCKER_OPTS=\"--bip #{CONFIG[:docker_br_ip]} --dns #{CONFIG[:docker_dns]}\""
  File.write '/etc/default/docker', docker_opts
  info t.name + ": starting Docker service"
  runcmd 'start docker'
  runcmd 'ip l s dev docker0 up'
  info t.name + ": finished"
end