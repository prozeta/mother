#!/bin/bash

sleep 2

exec /usr/sbin/named -4 -f -u bind
