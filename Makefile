include config.mk

# command aliases
apt_get := DEBIAN_FRONTEND=noninteractive apt-get -y
log := @echo ==========

# breakpoints
prepared := /.mother_fertile
done := /.mother_pregnant

# target aliases
pip := /usr/local/bin/pip
docker := /usr/bin/docker
docker_compose := /usr/local/bin/docker-compose
docker_registry := ${docker_dir}/registry
maestro := /usr/local/bin/maestro
named := /usr/sbin/named
dhcpd := /usr/sbin/dhcpd
nsupdate := /usr/bin/nsupdate

all: test_uid prepare pip docker docker_dir docker_compose docker_registry maestro dns
.PHONY: test_uid prepare pip docker docker_dir docker_compose docker_registry maestro dns

test_uid:
	test `id -u` == 0 || $(error You are not root)

prepare: ${prepared}
${prepared}: test_uid
	${log} Upgrading system
	${apt_get} update
	${apt_get} dist-upgrade
	${log} Installing base tools
	${apt_get} install wget python-software-properties python-dev python-yaml ruby git
	touch ${prepared}

pip: ${prepared} ${pip}
${pip}: ${prepared}
	${log} Installing pip
	wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O/tmp/get-pip.py
	python /tmp/get-pip.py
	rm -f /tmp/get-pip.py
	touch ${pip}

docker: ${docker}
${docker}: ${prepared}
	${log} Installing Docker
	wget -qO- https://get.docker.com/ | sh;
	${log} Stopping Docker
	stop docker || true
	/etc/init.d/docker stop || true
	${log} Removing Docker bridge \& iptables rules
	ip l s dev docker0 down
	brctl delbr docker0
	iptables-save -t nat | grep -i \\-A | grep -i docker | sed s/-A/-D/ | xargs -t -L1 iptables -t nat
	iptables-save -t filter | grep -i \\-A | grep -i docker | sed s/-A/-D/ | xargs -t -L1 iptables -t filter
	${log} Configuring Docker
	echo "DOCKER_OPTS=\"--bip ${docker_br_ip} --dns ${docker_dns}\"" > /etc/default/docker
	touch ${docker}
	${log} Starting Docker
	start docker

docker_dir: ${docker_dir}
${docker_dir}: ${docker}
	mkdir -p ${docker_dir}


docker_compose: ${docker_compose}
${docker_compose}: ${docker}
	curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > ${docker_compose}
	chmod +x ${docker_compose}

docker_registry: ${docker_registry}
${docker_registry}: ${docker} ${docker_dir} ${docker_compose}
	mkdir -p /tmp/build/docker_registry & cd /tmp/build/docker_registry
	rm -f Dockerfile
	echo "FROM registry:2.0" >> Dockerfile
	echo "RUN mkdir /data" >> Dockerfile
	echo "ENV REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY /data" >> Dockerfile
	echo "ENV REGISTRY_LOG_LEVEL debug" >> Dockerfile
	echo "EXPOSE 5000"" >> Dockerfile
	docker build --rm -t "base/docker-registry:latest" .
	docker create --name=docker-registry --publish=5000:5000 --volume=${docker_registry}:/data docker-registry
	# TODO

maestro: ${maestro}
${maestro}: ${prepared} ${docker} ${pip}
	${log} Installing Maestro NG
	${pip} install --upgrade git+git://github.com/signalfuse/maestro-ng
	touch ${maestro}

dns: ${named}
${named}: ${nsupdate} ${dns_key}
	${apt_get} install bind9 bind9utils
	/etc/init.d/bind9 stop
	touch ${named}

${nsupdate}:
	test -f ${nsupdate} || ( ${apt_get} install dnsutils; touch ${nsupdate} )

${dns_key}:
	test -f ${dns_key} || ( ddns-confgen -k foreman -a hmac-md5 | egrep -v '^#' > ${dns_key} )

dhcpd:
${dhcpd}:
	test -f ${dhcpd} || ( ${apt_get} install isc-dhcp-server && touch ${dhcpd) )

foreman_proxy:

certs:

