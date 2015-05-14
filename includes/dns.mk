${named}: ${nsupdate} ${dns_key}
ifeq ($(wildcard ${named}),)
	${apt_get} install bind9 bind9utils
	/etc/init.d/bind9 stop
endif

${nsupdate}:
ifeq ($(wildcard ${nsupdate}),)
	${apt_get} install dnsutils
endif

${dns_key}:
	ddns-confgen -k foreman -a hmac-md5 | egrep -v '^#' > ${dns_key}