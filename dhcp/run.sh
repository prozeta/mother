#!/bin/bash

sleep 2

exec /usr/sbin/dhcpd -f -4 -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases
