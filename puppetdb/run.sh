#!/bin/sh

b 'waiting for postgres and puppet certs to init'
while ! etcdctl get /_init/psql/create &>/dev/null || ! etcdctl get /_init/puppet/certs &>/dev/null; do
  echo -n .
  sleep 2
done

echo
bl 'starting PuppetDB'
USER=puppetdb
INSTALL_DIR=/usr/share/puppetdb
CONFIG=/etc/puppetdb/conf.d
JARFILE="puppetdb.jar"
JAVA_BIN=/usr/bin/java
JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/puppetdb/puppetdb-oom.hprof -Djava.security.egd=file:/dev/urandom"

cd ${INSTALL_DIR}
exec ${JAVA_BIN} ${JAVA_ARGS} -cp ${INSTALL_DIR}/${JARFILE} clojure.main -m com.puppetlabs.puppetdb.core services -c ${CONFIG}
