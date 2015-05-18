Docker Python Watcher image
===========================

Simple watcher on a file or a folder and post event on a HTTP backend.

How to use
----------

Start an instance

	docker run -d -v /srv/pictures:/data --name watcher -e PYWATCHER_FILE=/data -e PYWATCHER_URL=http://172.17.42.1:5000/publish ahmet2mir/pywatcher

with

PYWATCHER_FILE for the folder to watch, don't forget to attach it with -v
PYWATCHER_URL the http backend to POST the event

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
