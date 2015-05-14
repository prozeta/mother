${build_logger}: ${docker_buildpath}
	rm -rf ${docker_buildpath}/logger
	git clone https://github.com/prozeta/mother-logger.git ${docker_buildpath}/logger
	${docker_build} "mother/logger:latest" ${docker_buildpath}/logger
	docker export -o ${build_logger} "mother/logger:latest"

${build_puppetmaster}: ${docker_buildpath}
	rm -rf ${docker_buildpath}/puppetmaster
	git clone https://github.com/prozeta/mother-puppetmaster.git ${docker_buildpath}/puppetmaster
	${docker_build} "mother/puppetmaster:latest" ${docker_buildpath}/puppetmaster
	docker export -o ${build_puppetmaster} "mother/puppetmaster:latest"

# ${build_puppetdb}: ${docker_buildpath}
# 	rm -rf ${docker_buildpath}/puppetdb
# 	git clone https://github.com/prozeta/mother-puppetdb.git ${docker_buildpath}/puppetdb
# 	${docker_build} "mother/puppetdb:latest" ${docker_buildpath}/puppetdb
# 	docker export -o ${build_puppetdb} "mother/puppetdb:latest"

${build_foreman}: ${docker_buildpath}
	rm -rf ${docker_buildpath}/foreman
	git clone https://github.com/prozeta/mother-foreman.git ${docker_buildpath}/foreman
	${docker_build} "mother/foreman:latest" ${docker_buildpath}/foreman
	docker export -o ${build_foreman} "mother/foreman:latest"

