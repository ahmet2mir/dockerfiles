Docker Booking MVC image
========================

This is a Debian based image with [Booking-MVC](https://github.com/MathildeLemee/booking-mvc/) for 3 tiers demo

How to use
----------

The imade didn't provide the database, so use environment variables to run the app.

    docker run -d -p 8080:8080 --name booking -e DB_HOST="172.17.42.1" -e DB_PORT="5432" -e DB_USER="user" -e DB_PAASWORD="password" -e DB_NAME="leednew" -e TOMCAT_USER="admin" -e TOMCAT_PAASWORD="password" ahmet2mir/booking-mvc


You can use the fig http://fig.sh file and run it with a database from another image

	postgres:
	    image: postgres
	    environment:
	        POSTGRES_USER: "puser"
	        POSTGRES_PASSWORD: "ppwd"
	    ports:
	        - "5432:5432"

	phppgadmin:
	    image: jacksoncage/phppgadmin
	    environment:
	        POSTGRES_HOST: "172.17.42.1"
	        POSTGRES_PORT: "5432"
	        POSTGRES_DEFAULTDB: "postgres"
	    ports:
	        - "8085:80"

	booking:
	    image: ahmet2mir/booking-mvc
	    environment:
	        DB_HOST: "172.17.42.1"
	        DB_PORT: "5432"
	        DB_USER: "puser"
	        DB_PASSWORD: "ppwd"
	        DB_NAME: "postgres"

	        TOMCAT_USER: "tomcat"
	        TOMCAT_PASSWORD: "tomcat"
	    ports:
	        - "8080:8080"

Run it

    fig -p myproject up -d

Visit

* **phppgadmin**: http://localhost:8085
* **booking**: http://localhost:8080/booking-mvc


If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it leed /bin/bash
    or
    docker exec -it myproject_booking_1 /bin/bash

In Database

    docker exec -it myproject_postgres_1 /bin/bash

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
