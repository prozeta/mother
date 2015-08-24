all: uninstall install

install:
	/bin/mkdir -p /var/lib/mother/tasks /var/lib/mother/lib
	/usr/bin/find tasks -name *.rake | /usr/bin/xargs -L1 -I{} /usr/bin/install -D -o root -g root -m 644 {} /var/lib/mother/{}
	/usr/bin/find lib -name *.rb | /usr/bin/xargs -L1 -I{} /usr/bin/install -D -o root -g root -m 644 {} /var/lib/mother/{}
	/usr/bin/install -o root -g root -m 644 Rakefile /var/lib/mother/Rakefile
	[[ -e config.yaml ]] && /usr/bin/install -o root -g root -m 640 config.yaml /etc/mother.yaml
	/usr/bin/install -o root -g root -m 750 bin/mother /usr/local/sbin/mother

uninstall:
	/bin/rm -rf /var/lib/mother
	/bin/rm -f /etc/mother.yaml
	/bin/rm -f /usr/local/sbin/mother
