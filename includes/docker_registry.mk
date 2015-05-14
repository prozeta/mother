${docker_registry}: ${docker} ${docker_dir} ${docker_compose}
	mkdir -p ${docker_buildpath}/docker_registry
	cd ${docker_buildpath}/docker_registry
	rm -f Dockerfile
	echo "FROM registry:2.0" >> Dockerfile
	echo "RUN mkdir /data" >> Dockerfile
	echo "ENV REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY /data" >> Dockerfile
	echo "ENV REGISTRY_LOG_LEVEL debug" >> Dockerfile
	echo "EXPOSE 5000" >> Dockerfile
	docker build -q --rm -t "base/docker-registry:latest" .
	docker stop docker-registry || true
	docker rm docker-registry || true
	docker create --name=docker-registry --publish=5000:5000 --volume=${docker_registry}:/data 'base/docker-registry'
	mkdir -p ${docker_registry}
	docker start docker-registry