${postgres}:
ifeq ($(wildcard ${postgres}),)
	${apt_get} install postgresql-9.1
endif