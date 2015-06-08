${nsupdate}:
ifeq ($(wildcard ${nsupdate}),)
	${apt_get} install dnsutils
endif

${dns_key}:
	ddns-confgen -k foreman -a hmac-md5 | egrep -v '^#' > ${dns_key}