.PHONY: all build clean tag

TAG = 1.10.1_puppet3
DIRS = /srv/mother/cert /srv/mother/environments /srv/mother/pgdata /srv/mother/tftp /srv/mother/dhcp /srv/mother/dns /srv/mother/foreman /srv/mother/foreman/hooks

.PHONY: all help prepare docker directories maestro etcd config pull start stop status logs magic remove build rebuild clean tag

all: help
help:
	@echo 'System prepare:'
	@echo '  make docker         Install Docker Engine'
	@echo '  make etcd           Install and run ETCD locally'
	@echo '  make maestro        Install Maestro NG'
	@echo '  make directories    Prepare Host Directory'
	@echo 'Service:'
	@echo '  make config         Apply configuration from config.yaml (see example-config.yaml to get the idea)'
	@echo '  make pull           Pull the images from DockerHub'
	@echo '  make start          Start the services! :)'
	@echo '  make stop           Stop the services'
	@echo '  make status         State of the services'
	@echo '  make logs           See the log output of services'
	@echo 'Development:'
	@echo '  make rebuild'
	@echo '  make remove'
	@echo '  make clean'
	@echo '  make build'
	@echo '  make tag'

###########
# PREPARE #
###########
prepare: docker etcd maestro directories
docker: /usr/bin/docker /etc/default/docker
maestro: /usr/bin/pip /usr/local/bin/maestro
etcd: /usr/sbin/etcd
directories: $(DIRS)

$(DIRS):
	mkdir -p $(DIRS)

/usr/bin/docker:
	curl -sSL https://get.docker.com/ | sh

/usr/bin/pip:
	DEBIAN_FRONTEND=noninteractive apt-get install -qqy python-dev python-pip python-yaml

/usr/local/bin/maestro:
	pip install --upgrade maestro-ng

/etc/default/docker:
	stop docker
	echo "DOCKER=/usr/bin/docker" > /etc/default/docker
	echo "export TMPDIR=/tmp/" >> /etc/default/docker
	echo "DOCKER_OPTS='-H unix:///var/run/docker.sock'" >> /etc/default/docker
	start docker

/usr/sbin/etcd:
	DEBIAN_FRONTEND=noninteractive apt-get -qqy install etcd
	gem install --no-rdoc --no-ri etcd-tools

#######
# RUN #
#######
config: etcd docker
	test -e config.yaml
	yaml2etcd < config.yaml

pull: docker
	docker-compose pull $(TARGET)

start: docker
	docker-compose up -d $(TARGET)

stop: docker
	docker-compose stop $(TARGET)

status: docker
	docker-compose ps

logs: docker
	docker-compose logs

magic:
	docker-compose start psql
	docker-compose start dns
	docker-compose start dhcp
	docker-compose start tftp
	docker-compose start puppetmaster
	# sleep 10
	# docker-compose start puppetdb
	# docker-compose start smartproxy
  # sleep 10
	# docker-compose start foreman


#########
# BUILD #
#########
rebuild: stop clean build tag
remove: docker
	docker-compose -f docker-compose-build.yml rm $(TARGET)

clean: docker remove
	-docker images | grep -v baseimage | awk '/mother-$(TARGET)/ { print $$3 }' | xargs -r docker rmi -f

build: docker
	docker-compose -f docker-compose-build.yml build $(TARGET)

tag: docker
	docker images | awk '/mother_$(TARGET).*?latest/ { sub(/mother_/,"",$$1); print $$3" prozeta/mother-"$$1}' | xargs -r -L1 -IXX echo docker tag XX:$(TAG) | bash
	docker images | awk '/mother_$(TARGET).*?latest/ { sub(/mother_/,"",$$1); print $$3" prozeta/mother-"$$1}' | xargs -r -L1 -IXX echo docker tag XX:latest | bash
	-docker images | awk '/mother_$(TARGET)/ { print $$1 }' | xargs -r docker rmi
