#!/bin/bash

echo Running zou services...
gunicorn -t  $TIMEOUT -w $WORKERS zou.app:app
