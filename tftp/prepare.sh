#!/bin/bash

set -e

b 'copying PXE boot files from syslinux...'
mkdir -p /var/lib/tftpboot/boot
cp /usr/lib/syslinux/{chain.c32,menu.c32,pxelinux.0,memdisk} /var/lib/tftpboot
bl 'done'

if [ -d /var/lib/tftpboot/boot/fdi-image ]; then
  bl 'retrieving Foreman Discovery image'
  wget http://downloads.theforeman.org/discovery/releases/4.1/fdi-image-latest.tar -O - | tar x --overwrite -C /var/lib/tftpboot/boot
  bl 'done'
fi
