#!/bin/bash

set -e

if [ ! -d /etc/puppet/rack/public ] || [ ! -e /etc/puppet/rack/config.ru ]; then
  b 'bootstrapping Rack configuration...'
  mkdir -p /etc/puppet/rack/public
  etcd-erb < /cfg/config.ru.erb > /etc/puppet/rack/config.ru
  bl 'done'
fi

b "configuring NGINX vhost"
etcd-erb < /cfg/nginx.erb > /opt/nginx/conf/puppetmaster.conf
bl 'done'

b "configuring PuppetMaster..."
etcd-erb < /cfg/auth.conf.erb > /etc/puppet/auth.conf
etcd-erb < /cfg/autosign.conf.erb > /etc/puppet/autosign.conf
etcd-erb < /cfg/puppet.conf.erb > /etc/puppet/puppet.conf
etcd-erb < /cfg/puppetdb.conf.erb > /etc/puppet/puppetdb.conf
etcd-erb < /cfg/fileserver.conf.erb > /etc/puppet/fileserver.conf
etcd-erb < /cfg/Puppetfile.erb > /etc/puppet/Puppetfile
etcd-erb < /cfg/routes.yaml.erb > $(puppet master --configprint route_file)
bl "done"

E_STATUS_PATH=/_init/puppet/certs
if [ "`etcdctl get ${E_STATUS_PATH} 2>/dev/null`" != "done" ]; then
  bl "generating PuppetCA cert/keys"
  puppet cert list --all
  bl "PuppetCA cert/keys ready"

  KEY_NAME=$(hostname -f)
  if [ ! -f /var/lib/puppet/ssl/certs/${KEY_NAME}.pem ]; then
    bl "generating usage cert/keys"
    puppet cert generate ${KEY_NAME} --dns_alt_names $(hostname -s),$(etcdctl get /config/foreman/hostname),$(etcdctl get /config/puppet/master/hostname)
    bl "usage cert/keys ready"
  fi

  etcdctl set ${E_STATUS_PATH} 'done' &>/dev/null
else
  bl 'Puppet keys already generated'
fi

bl 'Downloading defined Puppet modules'
cd /etc/puppet
librarian-puppet config --rsync --global
librarian-puppet install --verbose
cd /
bl 'Puppet modules downloaded'

b 'Fixing ownership...'
chown -R puppet:puppet $(sudo puppet config print confdir)
bl 'done'
