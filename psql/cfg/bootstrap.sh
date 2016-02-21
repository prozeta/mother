#!/bin/bash

if psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='puppet'" | grep -q 1;
then
  bl "[puppet] user and DB already initialized"
else
  b '[puppet] creating user:'
  psql -c "CREATE USER puppet WITH PASSWORD '$(etcdctl get /config/auth/db/puppet)';"
  b '[puppet] creating DB...'
  createdb -O puppet puppet
  bl 'OK'
fi

if psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='foreman'" | grep -q 1;
then
  bl "[foreman] user and DB already initialized"
else
  b '[foreman] creating user:'
  psql -c "CREATE USER foreman WITH PASSWORD '$(etcdctl get /config/auth/db/foreman)';"
  b '[foreman] creating DB...'
  createdb -O foreman foreman
  bl 'OK'
fi
