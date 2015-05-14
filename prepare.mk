${prepared}:
  ${log} Upgrading system
  ${apt_get} update
  ${apt_get} dist-upgrade
  ${log} Installing base tools
  ${apt_get} install wget python-software-properties python-dev python-yaml ruby git
  touch ${prepared}