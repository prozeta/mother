${named}: ${nsupdate} ${dns_key}
	${apt_get} install bind9 bind9utils
	/etc/init.d/bind9 stop
	touch ${named}

${nsupdate}:
	test -f ${nsupdate} || ( ${apt_get} install dnsutils; touch ${nsupdate} )

${dns_key}:
	test -f ${dns_key} || ( ddns-confgen -k foreman -a hmac-md5 | egrep -v '^#' > ${dns_key} )