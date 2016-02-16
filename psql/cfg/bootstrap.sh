#!/bin/bash

if psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='puppet'" | grep -q 1;
then
  exit 0
else
  psql -c "CREATE USER puppet WITH PASSWORD '$(etcdctl get /config/auth/db/puppet)';"
  createdb -O puppet puppet
  exit 0
fi

if psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='foreman'" | grep -q 1;
then
  exit 0
else
  psql -c "CREATE USER foreman WITH PASSWORD '$(etcdctl get /config/auth/db/foreman)';"
  createdb -O foreman foreman
  exit 0
fi
