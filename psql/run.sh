#!/bin/bash

exec setuser postgres /usr/lib/postgresql/9.3/bin/postgres -c config_file=/etc/postgresql/9.3/main/postgresql.conf
