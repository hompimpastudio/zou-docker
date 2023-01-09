#!/bin/bash

echo Running zou services...
mkdir -p $PREVIEW_FOLDER
gunicorn -t  $TIMEOUT -w $WORKERS zou.app:app
