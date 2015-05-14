${nginx}:
  test -f ${nginx} || ( ${apt_get} install nginx && \
                        rm -f /etc/nginx/sites-enabled/* \
                              /etc/nginx/sites-available/* && \
                        touch ${nginx} \
                      )