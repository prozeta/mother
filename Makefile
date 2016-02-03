.PHONY: all build clean tag

TAG = 1.10.2_puppet3
TARGET =
DIRS = /srv/mother/cert /srv/mother/environments /srv/mother/pgdata /srv/mother/tftp /srv/mother/dhcp /srv/mother/dns /srv/mother/foreman /srv/mother/foreman/hooks

.PHONY: all build rebuild clean tag docker directories etcd start stop

rebuild: clean build tag
install: docker directories etcd pull start

docker: /usr/bin/docker /etc/default/docker

etcd: /usr/sbin/etcd


clean: docker
	docker-compose -f docker-compose-build.yml rm
	-docker images | awk '/mother_/ { print $$3 }' | xargs docker rmi -f

build: docker
	docker-compose -f docker-compose-build.yml build $(TARGET)

list: docker
	docker-compose ps

pull: docker
	docker-compose pull

start: docker
	docker-compose up

tag: docker
	docker images | awk '/mother_.*?latest/ { sub(/mother_/,"",$$1); print $$3" prozeta/mother-"$$1}' | xargs -L1 -IXX echo docker tag XX:$(TAG)

directories: $(DIRS)
$(DIRS):
	mkdir -p $(DIRS)

/usr/bin/docker:
	curl -sSL https://get.docker.com/ | sh

/etc/default/docker:
	stop docker
	echo "DOCKER=/usr/bin/docker" > /etc/default/docker
	echo "export TMPDIR=/tmp/" >> /etc/default/docker
	echo "DOCKER_OPTS='-H unix:///var/run/docker.sock'" >> /etc/default/docker
	start docker

/usr/sbin/etcd:
	DEBIAN_FRONTEND=noninteractive apt-get -qqy install etcd
