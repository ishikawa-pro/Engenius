#!/bin/sh

if [ ! -e tmp/pids/server.pid ]; then
    sleep 3
    rake db:create
    rake db:migrate
    rake db:seed
else
    #コンテナを落とすと、server.pidが残って次回正常にserverが立たないため
    rm tmp/pids/server.pid
fi
rails s -d -b 0.0.0.0

bundle exec rails runner Batch::GetArticles.get_articles
