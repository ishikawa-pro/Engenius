#!/bin/sh

rake db:create
rake db:migrate
rake db:seed
bundle exec rails runner Batch::GetArticles.get_articles &
rails s -b 0.0.0.0
