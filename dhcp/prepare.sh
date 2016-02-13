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
IP_ADDR_WITH_MASK=$(ip -4 -o a l dev eth0 | awk '{ print $4 }')
IP_NETWORK=$(ipcalc -nb ${IP_ADDR_WITH_MASK} | awk '/Network/ { sub(/\/.*/,"",$2); print $2 }')
IP_NETMASK=$(ipcalc -nb ${IP_ADDR_WITH_MASK} | awk '/Netmask/ { print $2 }')
if ! grep "subnet ${IP_NETWORK} netmask ${IP_NETMASK}" /etc/dhcp/dhcpd.conf; then
  echo "subnet ${IP_NETWORK} netmask ${IP_NETMASK} {}" >> /etc/dhcp/dhcpd.conf
fi
touch /var/lib/dhcp/dhcpd.leases
bl 'done'
