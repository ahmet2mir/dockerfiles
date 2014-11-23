Docker Rainloop
=============

Rainloop web client Docker image using nginx.

How to use
-------

	docker pull ahmet2mir/rainloop

Or run it directly (it will make the pull)

	docker run -d --name rainloop -h rainloop -p 8080:80 ahmet2mir/rainloop


Open your browser and visit 
	
	http://127.0.0.1:8080

Admin panel 

	http://127.0.0.1:8080/?admin
    login: admin
    password: 12345

You can use the Makefile to run some commands and build yours.
	
	make build
	make run
	make clean

To connect to the conainer, the base image is https://github.com/ahmet2mir/docker-debian, check it.

Backup
-----------

Data are stored in /webapps/rainloop/data, to externalize it, use -v option and sync data inside container OR you can run a first "dummy" container, copy data localy, destroy it, and re-run with -v.

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
