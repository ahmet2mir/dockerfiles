build:
	docker build -t ahmet2mir/shaarli .
run:
	docker run -d -p 8080:80 -P -h shaarli --name shaarli ahmet2mir/shaarli
clean:
	docker rm -f shaarli
log:
	docker logs -f shaarli
port:
	docker port shaarli 80
enter:
	docker exec -it shaarli /bin/bash