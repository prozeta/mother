#!/bin/bash

set -e

b 'copying PXE boot files from syslinux...'
mkdir -p /var/lib/tftpboot/boot
cp /usr/lib/syslinux/{chain.c32,menu.c32,pxelinux.0,memdisk} /var/lib/tftpboot
bl 'done'
