${puppetmaster}: ${buildpath}
	git clone https://github.com/prozeta/mother-puppetmaster.git ${buildpath}/puppetmaster

${puppetdb}: ${buildpath}
	git clone https://github.com/prozeta/mother-puppetdb.git ${buildpath}/puppetdb

${foreman}: ${buildpath}
	git clone https://github.com/prozeta/mother-foreman.git ${buildpath}/foreman

