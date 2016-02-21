#!/bin/bash

sleep 2

rm -f /var/run/dhcpd.pid

IFACE="`etcdctl get /config/dhcp/interface 2>/dev/null`"
[ -z $IFACE ] && IFACE="$(ip route list | awk '/default/ { print $5 }')"

exec /usr/sbin/dhcpd -f -4 -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases $IFACE
