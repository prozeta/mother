${prepared}:
	$(info Upgrading system)
	${apt_get} update
	${apt_get} dist-upgrade
	$(info Installing base tools)
	${apt_get} install wget python-software-properties python-dev python-yaml ruby git bridge-utils
	touch ${prepared}