FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
ADD run.sh /etc/service/foreman/run
EXPOSE 80 443 3443
VOLUME /var/lib/puppet/ssl
CMD [ "/sbin/my_init" ]
