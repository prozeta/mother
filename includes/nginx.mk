${nginx}:
ifeq ($(wildcard ${nginx}),)
	${apt_get} install nginx
	/etc/init.d/nginx stop || true
	rm -f /etc/nginx/sites-enabled/* /etc/nginx/sites-available/*
	touch ${nginx}
	/etc/init.d/nginx start
endif
