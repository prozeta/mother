${build_puppetmaster}: ${buildpath}
	git clone https://github.com/prozeta/mother-puppetmaster.git ${buildpath}/puppetmaster
	cd ${buildpath}/puppetmaster
	docker build --rm -t "mother/puppetmaster:latest" .
	docker export "mother/puppetmaster:latest" -o ${build_puppetmaster}

${build_puppetdb}: ${buildpath}
	git clone https://github.com/prozeta/mother-puppetdb.git ${buildpath}/puppetdb
	cd ${buildpath}/puppetdb
	docker build --rm -t "mother/puppetdb:latest" .
	docker export "mother/puppetdb:latest" -o ${build_puppetdb}

${build_foreman}: ${buildpath}
	git clone https://github.com/prozeta/mother-foreman.git ${buildpath}/foreman
	cd ${buildpath}/foreman
	docker build --rm -t "mother/foreman:latest" .
	docker export "mother/foreman:latest" -o ${build_foreman}

