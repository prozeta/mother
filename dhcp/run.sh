#!/bin/bash

sleep 2

IFACE="`etcdctl get /config/dhcp/interface 2>/dev/null`"
[ -z $IFACE ] && IFACE=eth0

exec /usr/sbin/dhcpd -f -4 -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases $IFACE
