#!/bin/bash

b 'waiting for puppet certs to init'
while ! etcdctl get /_init/puppet/certs &>/dev/null; do
  b .
  sleep 2
done
bl 'wait is over :)'

exec /usr/share/foreman-proxy/bin/smart-proxy
