#!/bin/bash

set -e

mkdir -p /var/lib/postgresql
chown -R postgres:postgres /var/lib/postgresql
chmod 700 /var/lib/postgresql

b 'applying configuration templates...'
etcd-erb < /cfg/pg_hba.conf.erb > /etc/postgresql/9.3/main/pg_hba.conf
etcd-erb < /cfg/postgresql.conf.erb > /etc/postgresql/9.3/main/postgresql.conf
bl 'done'

if [ ! -e /var/lib/postgresql/PG_VERSION ]; then
  bl 'initializing database...'
  sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D /var/lib/postgresql
  bl 'done'

  b 'setting database credentials...'
  /etc/init.d/postgresql start &>/dev/null && sleep 2
  sudo -u postgres psql -c "CREATE USER puppet WITH PASSWORD '$(etcdctl get /config/auth/db/puppet)';"
  sudo -u postgres psql -c "CREATE USER foreman WITH PASSWORD '$(etcdctl get /config/auth/db/foreman)';"
  sudo -u postgres createdb -O puppet puppet
  sudo -u postgres createdb -O foreman foreman
  /etc/init.d/postgresql stop &>/dev/null && sleep 1
  bl 'done'
fi
