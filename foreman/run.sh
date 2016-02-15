#!/bin/sh

sleep 2

exec /usr/sbin/apache2ctl -e info -D FOREGROUND
