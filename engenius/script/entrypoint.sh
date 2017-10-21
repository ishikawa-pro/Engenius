#!/bin/sh

if [ ! -e tmp/pids/server.pid ]; then
    #postgresのセットアップ終わるまでに、立ち上がることがあるので
    #暫定措置として3秒待つ
    sleep 3
    bin/rake db:create
    bin/rake db:migrate
    bin/rake db:seed
    bundle exec wheneverize . 
else
    #コンテナを落とすと、server.pidが残って次回正常にserverが立たないため
    rm tmp/pids/server.pid
fi

bundle exec rails runner Batch::GetArticles.get_articles &
rails s -b 0.0.0.0