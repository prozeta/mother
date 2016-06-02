#!/bin/bash

sleep 2

exec setuser postgres /usr/lib/postgresql/9.4/bin/postgres -c config_file=/etc/postgresql/9.4/main/postgresql.conf
