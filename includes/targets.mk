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
nginx := /usr/sbin/nginx
postgres := /usr/lib/postgresql/9.1/bin/postgres
foreman_proxy := /usr/share/foreman-proxy/bin/smart-proxy

# phony targets
all: prepare nginx postgres docker docker_registry maestro dhcp dns
.PHONY: prepare nginx postgres docker docker_registry maestro dhcp dns

# aliases
prepare: ${prepared}
nginx: ${nginx}
postgres: ${postgres}
docker: ${docker} ${docker_dir} ${docker_compose}
docker_registry: ${docker_registry}
maestro: ${pip} ${maestro}
dns: ${named}
dhcp: ${dhcpd}
# foreman_proxy: