#!/bin/bash

set -e

b 'copying PXE boot files from syslinux...'
mkdir -p /var/lib/tftpboot/boot
cp /usr/lib/syslinux/{chain.c32,menu.c32,pxelinux.0,memdisk} /var/lib/tftpboot
bl 'done'

if [ ! -d /var/lib/tftpboot/boot/fdi-image ]; then
  bl 'retrieving Foreman Discovery image'
  curl -o- http://downloads.theforeman.org/discovery/releases/latest/fdi-image-latest.tar 2>/dev/null | tar x --overwrite -C /var/lib/tftpboot/boot
  bl 'done'
fi
