#!/bin/bash

set -e

b 'checking if we already have a key defined...'

if etcdctl get /config/auth/keys/dns &>/dev/null
then
  bl 'YES'
else
  bl 'NO'
  b 'generating key...' &&\
    KEY=$(ddns-confgen -r /dev/urandom -k foreman -a hmac-md5 | awk '/secret/ { print substr($2,2,24) }') &&\
    bl 'done'
  b 'saving key to ETCD...' &&\
    etcdctl set /config/auth/keys/dns ${KEY} >/dev/null &&\
    bl 'done'
fi

b 'generating config files...'
etcd-erb < /cfg/named.conf.erb > /etc/bind/named.conf
etcd-erb < /cfg/named.conf.options.erb > /etc/bind/named.conf.options
etcd-erb < /cfg/named.conf.foreman-zones.erb > /etc/bind/named.conf.foreman-zones
etcd-erb < /cfg/named.conf.slave-zones.erb > /etc/bind/named.conf.slave-zones
etcd-erb < /cfg/named.conf.forward-zones.erb > /etc/bind/named.conf.forward-zones
etcd-erb < /cfg/rndc.key.erb > /etc/bind/rndc.key
bl 'done'

bl 'generating zone files...'
mkdir -p /etc/bind/zones.foreman
generate_zonefiles
chown -R bind:bind /etc/bind/
bl 'done'
