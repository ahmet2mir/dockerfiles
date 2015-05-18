# -*- coding: utf-8 -*-
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
"""
pywatcher
~~~~~~~~~~~~~~~~~~~~~~

Python file watcher and post changes

 :authors: Ahmet Demir <me@ahmet2mir.eu>
"""
# Import python libs
import os
import sys
import logging

# Import third party libs
import requests
import pyinotify

FILE = os.getenv('PYWATCHER_FILE', "/data")
URL = os.getenv('PYWATCHER_URL', "http://172.17.42.1:5000/publish")
logging.basicConfig(level=logging.INFO)
log = logging.getLogger("pywatcher")

class ModHandler(pyinotify.ProcessEvent):
    def process_IN_CLOSE_WRITE(self, evt):
        try:
            log.info("Event on file %s." % evt.name)
            requests.post(url=URL, data=evt.__dict__)
        except:
            pass


def main():
    log.info("Start watching %s and post event on %s." % (FILE, URL))
    handler = ModHandler()
    wm = pyinotify.WatchManager()
    notifier = pyinotify.Notifier(wm, handler)
    wdd = wm.add_watch(FILE, pyinotify.IN_CLOSE_WRITE)
    notifier.loop()


if __name__ == '__main__':
    sys.exit(main())