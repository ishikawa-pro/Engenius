build_dockers:
	docker build -t ishikawa314159/postgres9.5:engenius ./Docker/postgresServer/
	docker volume create --name EngeniusData
	docker run -it --rm -v EngeniusData:/var/lib/postgresql/9.5/main/ -d --name createClasster \
		ishikawa314159/postgres9.5:engenius
	docker stop createClasster
	docker create -it -v EngeniusData:/var/lib/postgresql/9.5/main/ --name EgDataContainer busybox
	docker build -t ishikawa314159/engenius ./Docker/railsServer/

