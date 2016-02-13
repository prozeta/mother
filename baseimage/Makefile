NAME = prozeta/mother-baseimage
PUPPET_VERSION = 3.8
FOREMAN_VERSION = 1.10.1
TAG = legacy

.PHONY: all build latest enter clean

all: clean build

clean:
	-docker rmi $(NAME):$(FOREMAN_VERSION)

build:
	docker build -t $(NAME):$(FOREMAN_VERSION) --build-arg FOREMAN_VERSION=$(FOREMAN_VERSION) --build-arg PUPPET_VERSION=$(PUPPET_VERSION) --rm .

latest:
	docker tag -f $(NAME):$(FOREMAN_VERSION) $(NAME):latest

enter:
	docker run --rm -it $(NAME):$(FOREMAN_VERSION) bash
