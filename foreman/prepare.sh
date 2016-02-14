#!/bin/bash

set -e

bl "configuring Foreman"
etcd-erb < /cfg/foreman-settings.erb > /etc/foreman/settings.yaml
etcd-erb < /cfg/foreman-database.erb > /etc/foreman/database.yml
bl "Foreman configured"

bl "running DB migration scripts"
foreman-rake db:migrate
bl "seeding default data into DB"
export SEED_ADMIN_PASSWORD="$(etcdctl get /config/auth/foreman/admin)"
foreman-rake db:seed
bl "DB updated :)"

# bl "building apipie cache"
# foreman-rake apipie:cache
# bl "apipie cache generated"

b 'enabling SSL...'
a2enmod ssl &>/dev/null
bl 'done'

b "configuring Apache vhost..."
etcd-erb /cfg/apache-vhost.erb > /etc/apache2/sites-available/foreman.conf
bl "done"
