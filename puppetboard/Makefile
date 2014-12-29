build:
	docker build -t ahmet2mir/puppetboard .
run:
	docker run -d -p 8090:9090 -h puppetboard --name puppetboard -e PUPPETDB_HOST="test.lan" -e PUPPETDB_PORT=8080 -e PUPPETDB_VERIFY=True ahmet2mir/puppetboard
clean:
	docker rm -f puppetboard
log:
	docker logs -f puppetboard
port:
	docker port puppetboard 9090
enter:
	docker exec -it puppetboard /bin/bash



	