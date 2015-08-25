FROM alpine:3.2
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

RUN apk add --update python openssl \
	&& wget http://bootstrap.pypa.io/get-pip.py \
	&& python get-pip.py \
	&& rm -rf /var/cache/apk/*

RUN pip install --upgrade pyinotify requests

COPY watch.py /watch.py
CMD python watch.py

# RUN sysctl -n -w fs.inotify.max_user_watches=16384
