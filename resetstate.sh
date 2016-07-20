#!/bin/sh -x
etcdctl rm /_init/foreman/cache
etcdctl rm /_init/foreman/db
etcdctl rm /_init/foreman/seed
etcdctl rmdir /_init/foreman

etcdctl rm /_init/psql/create
etcdctl rmdir /_init/psql

etcdctl rm /_init/puppet/certs
etcdctl rmdir /_init/puppet/
etcdctl rmdir /_init/

