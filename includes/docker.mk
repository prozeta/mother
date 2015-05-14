${docker}:
ifeq ($(wildcard ${docker}),)
	$(info Installing Docker)
	( wget -qO- https://get.docker.com/ | sh ) >/dev/null
	$(info Stopping Docker)
	stop docker || true
	/etc/init.d/docker stop || true
	$(info Removing Docker bridge \& iptables rules)
	ip l s dev docker0 down || true
	brctl delbr docker0 || true
	( iptables-save -t nat | grep -i \\-A | grep -i docker | sed s/-A/-D/ | xargs -t -L1 iptables -t nat ) || true
	( iptables-save -t filter | grep -i \\-A | grep -i docker | sed s/-A/-D/ | xargs -t -L1 iptables -t filter ) || true
	$(info Configuring Docker)
	echo "DOCKER_OPTS=\"--bip ${docker_br_ip} --dns ${docker_dns}\"" > /etc/default/docker
	touch ${docker}
	$(info Starting Docker)
	start docker
endif

${docker_dir}: ${docker}
	mkdir -p ${docker_dir}

${docker_buildpath}: ${docker}
	mkdir -p ${docker_buildpath}

${docker_compose}: ${docker}
ifeq ($(wildcard ${docker_compose}),)
	curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > ${docker_compose}
	chmod +x ${docker_compose}
endif