# breakpoints
prepared := /.mother_fertile
done := /.mother_pregnant

# target aliases
pip := /usr/local/bin/pip
docker := /usr/bin/docker

build_logger := ${docker_dir}/images/logger.tar
build_puppetmaster := ${docker_dir}/images/puppetmaster.tar
build_puppetdb := ${docker_dir}/images/puppetdb.tar
build_foreman := ${docker_dir}/images/foreman.tar
maestro := /usr/local/bin/maestro
named := /usr/sbin/named
dhcpd := /usr/sbin/dhcpd
nsupdate := /usr/bin/nsupdate
nginx := /usr/sbin/nginx
postgres := /usr/lib/postgresql/9.1/bin/postgres
foreman_proxy := /usr/share/foreman-proxy/bin/smart-proxy

# phony targets
all: prepare nginx postgres docker maestro dhcp dns
.PHONY: prepare nginx postgres docker maestro dhcp dns

# aliases
prepare: ${prepared}
nginx: ${nginx}
postgres: ${postgres}
docker: ${docker} ${docker_dir}
maestro: ${pip} ${maestro}
dns: ${named}
dhcp: ${dhcpd}