#!/bin/bash

set -e

b "configuring Foreman..."
etcd-erb < /cfg/foreman-settings.erb > /etc/foreman/settings.yaml
etcd-erb < /cfg/foreman-database.erb > /etc/foreman/database.yml
bl "done"

b 'waiting for postgres to init'
while ! etcdctl get /_init/psql/create &>/dev/null; do
  echo -n .
  sleep 2
done
bl 'wait is over :)'

E_STATUS_PATH=/_init/foreman/db
if [ "`etcdctl get ${E_STATUS_PATH} 2>/dev/null`" != "done" ]; then
  bl "running DB migration scripts"
  cd /usr/share/foreman
  sudo -H -u foreman foreman-rake db:migrate
  bl "DB updated :)"
  etcdctl set ${E_STATUS_PATH} done &>/dev/null
fi

E_STATUS_PATH=/_init/foreman/seed
if [ "`etcdctl get ${E_STATUS_PATH} 2>/dev/null`" != "done" ]; then
  bl "seeding default data into DB"
  sudo -H SEED_ADMIN_PASSWORD="$(etcdctl get /config/auth/foreman/admin)" -u foreman foreman-rake db:seed
  bl "DB updated :)"
  etcdctl set ${E_STATUS_PATH} done &>/dev/null
fi

E_STATUS_PATH=/_init/foreman/cache
if [ "`etcdctl get ${E_STATUS_PATH} 2>/dev/null`" != "done" ]; then
  bl "building apipie cache"
  sudo -H -u foreman foreman-rake apipie:cache
  bl "apipie cache generated"
  etcdctl set ${E_STATUS_PATH} done &>/dev/null
fi

b 'waiting for puppet certs to init'
while ! etcdctl get /_init/puppet/certs &>/dev/null; do
  echo -n .
  sleep 2
done
bl 'wait is over :)'

b "making Apache's copy of private key"
cp /var/lib/puppet/ssl/private_keys/$(hostname -f).pem /etc/foreman/private_key.pem
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

b "configuring foreman templates..."
su foreman -s /bin/bash -c "git config --global http.sslVerify false"
su foreman -s /bin/bash -c "ssh-keyscan git.prz > ~/.ssh/known_hosts 2>/dev/null"
foreman-rake templates:sync repo="https://git@git.prz/orchestration/templates.git" > /dev/null
bl "done"

