build:
	docker build -t ahmet2mir/jenkins .
run:
	docker run -d -p 8080:8080 -P -h jenkins --name jenkins ahmet2mir/jenkins
clean:
	docker rm -f jenkins
log:
	docker logs -f jenkins
port:
	docker port jenkins 8080
enter:
	docker exec -it jenkins /bin/bash