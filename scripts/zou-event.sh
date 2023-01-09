#!/bin/bash

echo Running zou-event services...
gunicorn -b 127.0.0.0:8001 -k geventwebsocket.gunicorn.workers.GeventWebSocketWorker -t $TIMEOUT -w 1 zou.event_stream:app
