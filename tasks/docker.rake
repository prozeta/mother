task :docker do
  runcmd '( wget -qO- https://get.docker.com/ | sh ) >/dev/null'
  runcmd 'stop docker || true'
  runcmd '/etc/init.d/docker stop || true'
  runcmd 'ip l s dev docker0 down || true'
  runcmd 'brctl delbr docker0 || true'
  runcmd 'iptables-save -t nat | grep -i \\\-A | grep -i docker | sed s/-A/-D/ | xargs -t -L1 iptables -t nat'
  runcmd 'iptables-save -t filter | grep -i \\\-A | grep -i docker | sed s/-A/-D/ | xargs -t -L1 iptables -t filter'
  docker_opts = "DOCKER_OPTS=\"--bip #{CONFIG[:docker_br_ip]} --dns #{CONFIG[:docker_dns]}\""
  File.write '/etc/default/docker', docker_opts
  runcmd 'start docker'
end