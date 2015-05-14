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

# phony targets
all: prepare docker docker_registry maestro
.PHONY: prepare docker docker_registry maestro

# aliases
prepare: ${prepared}
docker: ${docker} ${docker_dir} ${docker_compose}
docker_registry: ${docker_registry}
maestro: ${pip} ${maestro}
nginx: ${nginx}
dns: ${named}
dhcp: ${dhcpd}
# foreman_proxy: