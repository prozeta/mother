FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
ADD run.sh /etc/service/puppetmaster/run
EXPOSE 8140
VOLUME /etc/puppet /var/lib/puppet
CMD [ "/sbin/my_init" ]
