${pip}:
	$(info Installing pip)
	wget -q https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O/tmp/get-pip.py
	python /tmp/get-pip.py
	rm -f /tmp/get-pip.py
  rm -rf /tmp/pip_build_root
	touch ${pip}

${maestro}: ${pip}
	$(info Installing Maestro NG)
	${pip} install -q --upgrade git+git://github.com/signalfuse/maestro-ng
	touch ${maestro}