${build_puppetmaster}: ${docker_buildpath}
	rm -rf ${docker_buildpath}/puppetmaster
	git clone https://github.com/prozeta/mother-puppetmaster.git ${docker_buildpath}/puppetmaster
	cd ${docker_buildpath}/puppetmaster
	docker build --rm -t "mother/puppetmaster:latest" .
	docker export -o ${build_puppetmaster} "mother/puppetmaster:latest"

# ${build_puppetdb}: ${docker_buildpath}
# 	rm -rf ${docker_buildpath}/puppetdb
# 	git clone https://github.com/prozeta/mother-puppetdb.git ${docker_buildpath}/puppetdb
# 	cd ${docker_buildpath}/puppetdb
# 	docker build --rm -t "mother/puppetdb:latest" .
# 	docker export -o ${build_puppetdb} "mother/puppetdb:latest"

${build_foreman}: ${docker_buildpath}
	rm -rf ${docker_buildpath}/foreman
	git clone https://github.com/prozeta/mother-foreman.git ${docker_buildpath}/foreman
	cd ${docker_buildpath}/foreman
	docker build --rm -t "mother/foreman:latest" .
	docker export -o ${build_foreman} "mother/foreman:latest"

