#!/bin/bash

set -e

b 'generating config templates...'
etcd-erb < /cfg/dhcpd.conf.erb > /etc/dhcpd.conf
etcd-erb < /cfg/rndc.key.erb > /etc/rndc.key
etcd-erb < /cfg/settings.yml.erb > /etc/foreman-proxy/settings.yml
etcd-erb < /cfg/dhcp.yml.erb > /etc/foreman-proxy/settings.d/dhcp.yml
etcd-erb < /cfg/dhcp_isc.yml.erb > /etc/foreman-proxy/settings.d/dhcp_isc.yml
etcd-erb < /cfg/dns.yml.erb > /etc/foreman-proxy/settings.d/dns.yml
etcd-erb < /cfg/dns_nsupdate.yml.erb > /etc/foreman-proxy/settings.d/dns_nsupdate.yml
etcd-erb < /cfg/puppet.yml.erb > /etc/foreman-proxy/settings.d/puppet.yml
etcd-erb < /cfg/puppetca.yml.erb > /etc/foreman-proxy/settings.d/puppetca.yml
etcd-erb < /cfg/tftp.yml.erb > /etc/foreman-proxy/settings.d/tftp.yml
b 'done'

b 'adding user foreman-proxy to the puppet group...'
gpasswd -a foreman-proxy puppet &>/dev/null
bl 'done'
