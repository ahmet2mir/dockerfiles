build:
	docker build -t ahmet2mir/pypiserver .
run:
	docker run -d -p 8080:80 -P -h pypiserver --name pypiserver ahmet2mir/pypiserver
clean:
	docker rm -f pypiserver
log:
	docker logs -f pypiserver
port:
	docker port pypiserver 80
enter:
	docker exec -it pypiserver /bin/bash