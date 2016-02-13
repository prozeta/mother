#!/bin/bash

set -e

b 'setting database credentials...'
/etc/init.d/postgresql start &>/dev/null && sleep 2

sudo -u postgres psql -c "CREATE USER puppet WITH PASSWORD '$(etcdctl get /config/auth/db/puppet)';" &>/dev/null || true
sudo -u postgres psql -c "CREATE USER foreman WITH PASSWORD '$(etcdctl get /config/auth/db/foreman)';" &>/dev/null || true

sudo -u postgres createdb -O puppet puppet &>/dev/null || true
sudo -u postgres createdb -O foreman foreman &>/dev/null || true

/etc/init.d/postgresql stop &>/dev/null && sleep 1
bl 'done'

b 'applying configuration templates...'
etcd-erb < /cfg/pg_hba.conf.erb > /etc/postgresql/9.3/main/pg_hba.conf
etcd-erb < /cfg/postgresql.conf.erb > /etc/postgresql/9.3/main/postgresql.conf
bl 'done'
