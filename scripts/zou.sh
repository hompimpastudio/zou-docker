#!/bin/bash

echo Running zou services...
gunicorn -b 127.0.0.0:8000 -k gevent -t $TIMEOUT -w $WORKERS zou.app:app
