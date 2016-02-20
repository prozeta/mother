#!/bin/bash

b 'waiting for puppet certs to init'
while ! etcdctl get /_init/puppet/certs &>/dev/null; do
  echo -n .
  sleep 2
done

echo
bl 'starting SmartProxy'
exec /usr/share/foreman-proxy/bin/smart-proxy
