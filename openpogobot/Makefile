build:
	docker build -t ahmet2mir/openpogobot .
run:
	docker run -d -h openpogobot --name openpogobot ahmet2mir/openpogobot
clean:
	docker rm -f openpogobot
log:
	docker logs -f openpogobot
enter:
	docker exec -it openpogobot bash