FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
ADD run.sh /etc/service/dhcp/run
EXPOSE 69
VOLUME /var/lib/dhcp
CMD [ "/sbin/my_init" ]
