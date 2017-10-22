#!/bin/sh

if [ -e tmp/pids/server.pid ]; then
    #コンテナを落とすと、server.pidが残って次回正常にserverが立たないため
    rm tmp/pids/server.pid
fi

bundle exec rails runner Batch::GetArticles.get_articles &
rails s -b 0.0.0.0
