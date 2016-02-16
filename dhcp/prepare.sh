#!/bin/bash

set -e

b 'checking if we already have a key defined...'

if etcdctl get /config/auth/keys/dhcp &>/dev/null
then
  bl 'YES'
else
  bl 'NO'
  b 'generating key...' &&\
    dnssec-keygen -r /dev/urandom -a HMAC-MD5 -b 512 -n HOST -K /tmp/ omapi &&\
    bl 'done'
  b 'saving key to ETCD...' &&\
    etcdctl set /config/auth/keys/dhcp $(awk '/^Key:/  { print $2 }' /tmp/Komapi.+*.private) >/dev/null &&\
    rm -f /tmp/Komapi.+* &&\
    bl 'done'
fi

b 'applying configuration template...'
etcd-erb < /cfg/dhcpd.conf.erb > /etc/dhcp/dhcpd.conf
touch /var/lib/dhcp/dhcpd.leases
bl 'done'
