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
nginx := /usr/sbin/nginx
user := $(shell whoami)

# bail out if not root
ifneq (${user},root)
$(error You are not root!)
endif

all: prepare docker docker_registry maestro
.PHONY: prepare docker docker_registry maestro

prepare: ${prepared}
docker: ${docker} ${docker_dir} ${docker_compose}
docker_registry: ${docker_registry}
maestro: ${pip} ${maestro}
nginx: ${nginx}
dns: ${named}
dhcp: ${dhcpd}
# foreman_proxy:

include prepare.mk
include nginx.mk
include foreman_proxy.mk
include dns.mk
include dhcp.mk
include docker.mk
include docker_registry.mk
include maestro.mk





