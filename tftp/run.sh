#!/bin/sh
exec /usr/sbin/in.tftpd --foreground --user tftp --address 0.0.0.0:69 --secure /var/lib/tftpboot