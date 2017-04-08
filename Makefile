build_containers:
	docker build -t ishikawa314159/postgres9.5:engenius ./Docker/postgresServer/
	docker volume create --name EngeniusData
	docker run -it --rm -v EngeniusData:/var/lib/postgresql/9.5/main/ -d --name createClasster \
		ishikawa314159/postgres9.5:engenius
	docker stop createClasster
	docker create -it -v EngeniusData:/var/lib/postgresql/9.5/main/ --name EgDataContainer busybox
	docker build -t ishikawa314159/engenius ./Docker/railsServer/
setup_database:
	docker-compose up -d
	docker-compose exec web rake db:create
	docker-compose exec web rake db:migrate
	docker-compose exec web rake db:seed
	docker-compose exec web bundle exec rails runner Batch::GetArticles.get_articles
	docker-compose down 
get_data:
	docker-compose up -d
	docker-compose exec web bundle exec rails runner Batch::GetArticles.get_articles
	docker-compose down 
