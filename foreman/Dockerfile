FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
ADD run.sh /etc/service/foreman/run
EXPOSE 80 443
VOLUME /etc/puppet /var/lib/puppet/ssl /usr/share/foreman/config/hooks
CMD [ "/sbin/my_init" ]
