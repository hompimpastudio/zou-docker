#!/bin/bash

echo Running supervisord...
supervisord --nodaemon --configuration /etc/supervisord.conf
