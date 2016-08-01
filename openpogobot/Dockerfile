FROM alpine:edge
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

# install base tool for python
RUN apk add --update bash g++ gcc git linux-headers make openssl openssl-dev py-setuptools python python-dev python3 python3-dev

# install pip with easy_install (more recent)
RUN easy_install-2.7 pip && easy_install-3.5 pip

# upgrade and install tools
RUN pip install --upgrade pip virtualenv gunicorn setuptools

# install openpogo in /apps
RUN mkdir /apps
RUN cd /apps && git clone --recursive https://www.github.com/OpenPoGo/OpenPoGoBot openpogobot
RUN cd /apps/openpogobot && pip2 install -r requirements.txt

# Set the environment dir
WORKDIR /apps/openpogobot

# clean cache
RUN rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/python2", "pokecli.py"]
# default param
CMD ["--help"]