build:
	docker build -t ahmet2mir/reverseproxy .
run:
	docker run -d -p 443:443 -P -h reverseproxy --name reverseproxy ahmet2mir/reverseproxy
clean:
	docker rm -f reverseproxy
log:
	docker logs -f reverseproxy
port:
	docker port reverseproxy 443
enter:
	docker exec -it reverseproxy /bin/bash