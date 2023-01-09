#!/bin/bash

echo Running zou services...
gunicorn -b 127.0.0.0:8000 -k gevent -t 300 -w $WORKERS zou.app:app
