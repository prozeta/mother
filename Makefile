apt_get := DEBIAN_FRONTEND=noninteractive apt-get -y
log := @echo ==========

prepared := /.mother_fertile
done := /.mother_pregnant

pip := /usr/local/bin/pip
docker := /usr/bin/docker
maestro := /usr/local/bin/maestro
docker_dir := /container_data
named := /usr/sbin/named
dhcpd := /usr/sbin/dhcpd
nsupdate := /usr/bin/nsupdate

all: prepare pip docker docker_dir maestro dns

prepare: ${prepared}
${prepared}:
	${log} Upgrading system
	${apt_get} update
	${apt_get} dist-upgrade
	${log} Installing base tools
	${apt_get} install wget python-software-properties python-dev python-yaml ruby
	touch ${prepared}

pip: ${prepared} ${pip}
${pip}: 
	${log} Installing pip
	wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O/tmp/get-pip.py
	python /tmp/get-pip.py
	rm -f /tmp/get-pip.py
	touch ${pip}

docker: ${prepared} ${docker}
${docker}:
	${log} Installing Docker
	wget -qO- https://get.docker.com/ | sh;
	touch ${docker}

docker_dir: ${docker}
${docker_dir}:
	mkdir -p ${docker_dir}
	mkdir -p ${docker_dir}/foreman
	mkdir -p ${docker_dir}/puppetmaster
	mkdir -p ${docker_dir}/puppetdb


maestro: ${prepared} ${docker} ${pip} ${maestro}
${maestro}: 
	${log} Installing Maestro NG
	${pip} install --upgrade git+git://github.com/signalfuse/maestro-ng
	touch ${maestro}

dns: ${named} ${nsupdate} ${dns_key}
${named}:
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

