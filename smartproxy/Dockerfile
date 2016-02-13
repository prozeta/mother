FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
ADD run.sh /etc/service/smartproxy/run
EXPOSE 8443
VOLUME /var/lib/puppet/ssl /etc/puppet /var/lib/dhcp
CMD [ "/sbin/my_init" ]
