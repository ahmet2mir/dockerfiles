build:
	docker build -t ahmet2mir/rainloop .
run:
	docker run -d -p 8080:80 -P -h rainloop --name rainloop ahmet2mir/rainloop
clean:
	docker rm -f rainloop
log:
	docker logs -f rainloop
port:
	docker port rainloop 22
ssh:
	ssh rainloop.dock