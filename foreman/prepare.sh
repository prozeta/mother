#!/bin/bash

set -e

bl "setting hostname"
sudo hostname $(etcdctl get /config/foreman/hostname)
hostname
bl "hostname set"

bl "Configuring Foreman"
etcd-erb < /cfg/foreman-settings.erb > /etc/foreman/settings.yaml
etcd-erb < /cfg/foreman-database.erb > /etc/foreman/database.yml
bl "Foreman configured"

bl "running DB migration scripts"
foreman-rake db:migrate
bl "seeding default data into DB"
foreman-rake db:seed
bl "DB updated :)"

#
# FIXME: prepare certificate
#

bl "configuring NGINX vhost"
etcd-erb /cfg/nginx-foreman.erb > /opt/nginx/conf/foreman.conf
bl "NGINX vhost configured"
