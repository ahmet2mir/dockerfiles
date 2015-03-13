build:
	docker build -t ahmet2mir/booking-mvc .
run:
	docker run -d -p 8080:8080 -h booking-mvc --name booking-mvc ahmet2mir/booking-mvc
clean:
	docker rm -f booking-mvc
log:
	docker logs -f booking-mvc
port:
	docker port booking-mvc 8080
enter:
	docker exec -it booking-mvc /bin/bash



