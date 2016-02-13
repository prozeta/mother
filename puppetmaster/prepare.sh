#!/bin/bash

set -e

b "configuring NGINX vhost"
etcd-erb < /cfg/nginx.erb > /opt/nginx/conf/puppetmaster.conf
bl 'done'

b "configuring PuppetMaster..."
etcd-erb < /cfg/auth.conf.erb > /etc/puppet/auth.conf
etcd-erb < /cfg/autosign.conf.erb > /etc/puppet/autosign.conf
etcd-erb < /cfg/puppet.conf.erb > /etc/puppet/puppet.conf
etcd-erb < /cfg/fileserver.conf.erb > /etc/puppet/fileserver.conf
etcd-erb < /cfg/Puppetfile.erb > /etc/puppet/Puppetfile
bl "done"

bl "generating PuppetCA cert/keys"
puppet ca list
bl "PuppetCA cert/keys ready"

KEY_NAME=`hostname -f`
if [ ! -f /var/lib/puppet/ssl/certs/${KEY_NAME}.pem ]; then
  bl "generating PuppetMaster cert/keys"
  puppet cert generate ${KEY_NAME}
  puppet cert sign ${KEY_NAME}
  bl "PuppetMaster cert/keys ready"
fi

KEY_NAME=`etcdctl get /config/foreman/hostname`
if [ ! -f /var/lib/puppet/ssl/certs/${KEY_NAME}.pem ]; then
  bl "generating Foreman cert/keys"
  puppet cert generate ${KEY_NAME}
  puppet cert sign ${KEY_NAME}
  bl "Foreman cert/keys ready"
fi

bl 'Downloading defined Puppet modules'
cd /etc/puppet
librarian-puppet config --rsync true --global
librarian-puppet install --verbose
cd /
bl 'Puppet modules downloaded'
