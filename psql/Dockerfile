FROM prozeta/mother-baseimage
MAINTAINER Radek Slavicinsky "radek@blufor.cz"
ADD run.sh /etc/service/postgresql/run
EXPOSE 5432
VOLUME /var/lib/postgresql
CMD [ "/sbin/my_init" ]
