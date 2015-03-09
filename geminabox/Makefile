build:
	docker build -t ahmet2mir/geminabox .
run:
	docker run -d -p 9292:9292 -P -h geminabox --name geminabox -e USERNAME=ahmet -e PASSWORD=toto ahmet2mir/geminabox
clean:
	docker rm -f geminabox
log:
	docker logs -f geminabox
port:
	docker port geminabox 9292
enter:
	docker exec -it geminabox /bin/bash