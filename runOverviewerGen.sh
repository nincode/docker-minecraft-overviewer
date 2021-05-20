#!/bin/sh
LOG=/home/relja/docker/docker-minecraft-overviewer/logs/overViewer.log
echo 'Starting overviewer' | ts >> $LOG
cd /home/relja/docker/docker-minecraft-overviewer
docker-compose up >> $LOG 2>&1
echo 'Done ========================================' | ts >> $LOG
