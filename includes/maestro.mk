${pip}:
	$(info Installing pip)
	wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O/tmp/get-pip.py
	python /tmp/get-pip.py
	rm -f /tmp/get-pip.py
	touch ${pip}

${maestro}: ${pip}
	$(info Installing Maestro NG)
	${pip} install --upgrade git+git://github.com/signalfuse/maestro-ng
	touch ${maestro}