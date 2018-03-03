sleep 3
bin/rake db:drop
bin/rake db:create
bin/rake db:migrate
bin/rake db:seed

bundle exec rails runner Batch::GetArticles.get_articles &
rails s -b 0.0.0.0
