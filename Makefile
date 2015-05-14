ifneq ($(shell whoami),root)
$(error You are not root!)
endif

apt_get := DEBIAN_FRONTEND=noninteractive apt-get -qqy
docker_build := docker build --rm -q -t

include config.mk
include includes/targets.mk
include includes/prepare.mk
include includes/postgres.mk
include includes/nginx.mk
include includes/foreman_proxy.mk
include includes/dns.mk
include includes/dhcp.mk
include includes/docker.mk
include includes/docker_registry.mk
include includes/docker_images.mk
include includes/maestro.mk
