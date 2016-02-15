#!/bin/bash

set -e

b "configuring Foreman..."
etcd-erb < /cfg/foreman-settings.erb > /etc/foreman/settings.yaml
etcd-erb < /cfg/foreman-database.erb > /etc/foreman/database.yml
bl "done"

bl "running DB migration scripts"
foreman-rake db:migrate
bl "seeding default data into DB"
export SEED_ADMIN_PASSWORD="$(etcdctl get /config/auth/foreman/admin)"
foreman-rake db:seed
bl "DB updated :)"

bl "building apipie cache"
foreman-rake apipie:cache
bl "apipie cache generated"

b "making Apache's copy of private key"
cp /var/lib/puppet/ssl/private_keys/$(etcdctl get /config/puppet/master/hostname).pem /etc/foreman/private_key.pem
chown foreman:foreman /etc/foreman/private_key.pem
chmod 0400 /etc/foreman/private_key.pem
bl 'done'

b 'generating apache2.conf...'
etcd-erb < /cfg/apache2.conf.erb > /etc/apache2/apache2.conf
bl 'done'

b 'modifying default CustomLog...'
etcd-erb < /cfg/other-vhosts-access-log.conf.erb > /etc/apache2/conf-available/other-vhosts-access-log.conf
bl 'done'

b 'disablind default vhost...'
a2dissite 000-default &>/dev/null
bl 'done'

b 'enabling SSL...'
a2enmod ssl &>/dev/null
bl 'done'

b "configuring Apache vhost..."
etcd-erb < /cfg/apache-vhost.erb > /etc/apache2/sites-available/foreman.conf
bl "done"
