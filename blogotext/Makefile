build:
	docker build -t ahmet2mir/blogotext .
run:
	docker run -d -p 8080:80 -P -h blogotext --name blogotext ahmet2mir/blogotext
clean:
	docker rm -f blogotext
log:
	docker logs -f blogotext
port:
	docker port blogotext 80
enter:
	docker exec -it blogotext /bin/bash