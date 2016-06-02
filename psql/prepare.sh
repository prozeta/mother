#!/bin/bash

set -e

mkdir -p /var/lib/postgresql
chown -R postgres:postgres /var/lib/postgresql
chmod 700 /var/lib/postgresql

b 'applying configuration templates...'
etcd-erb < /cfg/pg_hba.conf.erb > /etc/postgresql/9.4/main/pg_hba.conf
etcd-erb < /cfg/postgresql.conf.erb > /etc/postgresql/9.4/main/postgresql.conf
bl 'done'

if [ ! -e /var/lib/postgresql/PG_VERSION ]; then
  bl 'initializing database...'
  sudo -u postgres /usr/lib/postgresql/9.4/bin/initdb -D /var/lib/postgresql
  bl 'done'
fi

E_STATUS_PATH=/_init/psql/create
if [ "`etcdctl get ${E_STATUS_PATH} 2>/dev/null`" != "done" ]; then

  bl 'setting database credentials...'
  /etc/init.d/postgresql start &>/dev/null && sleep 5
  sudo -u postgres /cfg/bootstrap.sh
  /etc/init.d/postgresql stop &>/dev/null && sleep 1
  bl 'done'

  etcdctl set ${E_STATUS_PATH} 'done' &>/dev/null
fi
