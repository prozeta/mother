# breakpoints
prepared := /.mother_fertile
done := /.mother_pregnant

# target aliases
pip := /usr/local/bin/pip
docker := /usr/bin/docker

maestro := /usr/local/bin/maestro
dhcrelay := /usr/sbin/dhcrelay
nsupdate := /usr/bin/nsupdate
foreman_proxy := /usr/share/foreman-proxy/bin/smart-proxy

# phony targets
all: prepare nginx postgres docker maestro dhcp dns
.PHONY: prepare nginx postgres docker maestro dhcp dns

# aliases
prepare: ${prepared}
nginx: ${nginx}
docker: ${docker} ${docker_dir}
maestro: ${pip} ${maestro}
dns: ${nsupdate} ${dns_key}
dhcp: ${dhcrelay}