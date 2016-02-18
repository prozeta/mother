#!/bin/sh

b 'waiting for postgres and puppet certs to init'
while ! etcdctl get /_init/psql/create &>/dev/null || ! etcdctl get /_init/puppet/certs &>/dev/null; do
  echo -n .
  sleep 2
done
bl 'wait is over :)'

exec /usr/sbin/apache2ctl -e info -D FOREGROUND
