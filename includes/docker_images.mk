${build_puppetmaster}: ${buildpath}
	rm -rf ${buildpath}/puppetmaster
	git clone https://github.com/prozeta/mother-puppetmaster.git ${buildpath}/puppetmaster
	cd ${buildpath}/puppetmaster
	docker build --rm -t "mother/puppetmaster:latest" .
	docker export -o ${build_puppetmaster} "mother/puppetmaster:latest"

# ${build_puppetdb}: ${buildpath}
# 	rm -rf ${buildpath}/puppetdb
# 	git clone https://github.com/prozeta/mother-puppetdb.git ${buildpath}/puppetdb
# 	cd ${buildpath}/puppetdb
# 	docker build --rm -t "mother/puppetdb:latest" .
# 	docker export -o ${build_puppetdb} "mother/puppetdb:latest"

${build_foreman}: ${buildpath}
	rm -rf ${buildpath}/foreman
	git clone https://github.com/prozeta/mother-foreman.git ${buildpath}/foreman
	cd ${buildpath}/foreman
	docker build --rm -t "mother/foreman:latest" .
	docker export -o ${build_foreman} "mother/foreman:latest"

