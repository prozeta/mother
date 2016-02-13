#!/bin/bash

set -e

if [ -e '/var/log/puppetdb/puppetdb-oom.hprof' ]
then
  b "moving old heapdump..."
  mv /var/log/puppetdb/puppetdb-oom.hprof /var/log/puppetdb/puppetdb-oom.hprof.$(date +%Y-%m-%d-%H-%M-%S)
  bl 'done'
fi

b "applying configuration templates..."
etcd-erb < /cfg/jetty.ini.erb > /etc/puppetdb/conf.d/jetty.ini
etcd-erb < /cfg/config.ini.erb > /etc/puppetdb/conf.d/config.ini
etcd-erb < /cfg/repl.ini.erb > /etc/puppetdb/conf.d/repl.ini
etcd-erb < /cfg/database.ini.erb > /etc/puppetdb/conf.d/database.ini
bl "done"
