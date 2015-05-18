FROM python:2.7

RUN pip install pyinotify requests
COPY watch.py /watch.py
CMD python watch.py

# RUN sysctl -n -w fs.inotify.max_user_watches=16384
