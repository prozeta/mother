${nginx}:
ifeq ($(wildcard ${nginx}),)
  ${apt_get} install nginx
  rm -f /etc/nginx/sites-enabled/* /etc/nginx/sites-available/*
  touch ${nginx}
endif
