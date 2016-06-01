#!/bin/bash

set -e
b 'saving required versions into /etc/mother-versions...'
echo "# generated on image build
export PUPPET_VERSION=${PUPPET_VERSION}
export FOREMAN_VERSION=${FOREMAN_VERSION}
" > /etc/mother-versions
bl 'done'

PV=( `echo -n ${PUPPET_VERSION} | sed 's/\./ /g'` )
FV=( `echo -n ${FOREMAN_VERSION} | sed 's/\./ /g'` )
if [ ${PV[0]} -lt 4 ]; then
  PUPPET_REL_PKG_NAME=puppetlabs-release-trusty
else
  PUPPET_REL_PKG_NAME=puppetlabs-release-pc1-trusty
fi

b 'adding repositories...'
echo "deb http://deb.theforeman.org/ trusty ${FV[0]}.${FV[1]}" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins ${FV[0]}.${FV[1]}" >> /etc/apt/sources.list.d/foreman.list
curl http://deb.theforeman.org/pubkey.gpg | apt-key add -
curl https://apt.puppetlabs.com/${PUPPET_REL_PKG_NAME}.deb -o/tmp/${PUPPET_REL_PKG_NAME}.deb
dpkg -i /tmp/${PUPPET_REL_PKG_NAME}.deb
rm -f /tmp/${PUPPET_REL_PKG_NAME}.deb
bl 'done'

b 'updating repositories...'
apt-get -qqy update
apt-get dist-upgrade -yyyy
apt-get clean
bl 'done'
