#!/bin/sh

if [ -e engenius/tmp/pids/server.pid ]; then
    echo "server.pidを削除"
    rm engenius/tmp/pids/server.pid
fi

VOLUME=(`docker volume ls -q | grep engenius_egdb`)
if [ -n "$VOLUME" ]; then
    docker volume rm $VOLUME
fi

docker-compose up -d
