FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
COPY generate_zonefiles /bin/
ADD run.sh /etc/service/bind/run
EXPOSE 53
VOLUME /etc/bind/zones.foreman
CMD [ "/sbin/my_init" ]
