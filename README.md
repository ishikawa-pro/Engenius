# Engenius server
 Engeniusという技術ブログのニュースアプリのサーバーサイドです。  
 名前は技術者(Engineer)の賢い(Genius)情報収集アプリを目指しているので、  
Engineer + Genius = Engeniusです笑  
 はてなブックマークのブックマーク数の多い最新の記事をスクレイピングして
データベースに蓄え、Ruby on Railsを使ってJSONで記事の情報を返します。  

 最終的には機械学習などを利用して、人気のある記事をスクレイピングしていく仕様
にしていきたいです。  

iOS用のクライアントアプリはこちら  
https://github.com/ishikawa-pro/Engenius_client
## Description
* Rubyを使って各キーワード毎に、はてなブックマークで検索し一定以上のブックマー
ク数の記事を日付順にソートしてスクレイピングしています。  
ex) Docker: http://b.hatena.ne.jp/search/text?safe=on&q=Docker&users=50  
* バックエンドはRailsとPostgreSQLを利用しており、全てDockerで管理しています。
## Setup
Engeniusのサーバーを利用する前のセットアップの方法についてです。Makefileを使ってセットアップしていくようにしてい
ます。  
✳︎ Dockerが動く状態になっていることが前提です。  
### コンテナの作成
RailsとPostgreSQLのコンテナを作成します。Railsのバージョンは5、PostgreSQLは9.5を利用しています。  
PostgreSQLはデータボリュームコンテナを作成してデータを永続化するようにしています。
データベースのユーザーとパスワードは、  
`User: engenius, password: engenius`  
です。変更する場合は、  
`Docker/postgresServer/Dockerfile`の中程にある、  
`    psql --command "CREATE ROLE engenius LOGIN CREATEDB PASSWORD 'engenius';" &&\`  
を編集してください。  
コンテナの作成はMakefileのある場所で以下のコマンドを叩いてください。  
`make build_containers`  
### データベースの作成とデータの流し込み
データベースの作成とデータの流し込みを行います。以下のコマンド一発で全て行われます。  
'make setup_database'  
データの流し込みは、最初にseeds.rbでデータベースにスクレイピングするキーワードとスクレイピング先のURLを登録します。
次に、Categoryテーブルに登録したカテゴリのデータを元にスクレイピングをしていきます。スクレイピングのバッチファイル
は、`Docker/railsServer/engenius/lib`内にある、`batch`と`hb_provide_lib`にあります。  
### データの取得
新しいデータを取得する際は、コンテナが起動していない場合は、  
`make get_data`  
コンテナが起動している場合は、  
`docker-compose exec web bundle exec rails runner Batch::GetArticles.get_articles`  
で、スクレイピングが始まります。
## Usage
### サーバーの起動
サーバーの立ち上げ方についてです。  
まず、コンテナを立ち上げます。  
`docker-compose up -d`  
railsコンテナのrails サーバーを立ち上げます。  
`docker-compose exec web rails s -b 0.0.0.0`  
これで、サーバーが動き始めましす。
### APIリファレンス
APIの仕様について  
* **[GET]最新記事一覧**  
    カテゴリに関係なく、執筆日の新しい順に記事の情報を返します。  
    ##### Request URL  
    `http://localhost:3000/article.json[?limit][&offset]`  
    ##### Requset parameters
    |param|Description|
    |---|---|
    |limit |何個の記事の情報を取得するかを指定できます。|  
    |offset|記事の情報を上から何個飛ばすか指定できます。|  
    #### Response
    ```JSON
	[
    {
        "title": "Docker上のRedashのデータをなくしてから復旧するまでの全記録 - Kuchitama Tech Note",
        "link": "http://kuchitama.hateblo.jp/entry/redash_on_docker_trouble",
        "post_date": "2017-04-05",
        "image_url": "https://cdn-ak.f.st-hatena.com/images/fotolife/k/kuchitama/20170405/20170405144512.png",
        "category": "Docker"
    },
    {
        "title": "[小ネタ] Docker for Mac のデータを縮小する（Docker.qcow2 の肥大化対策） | Developers.IO",
        "link": "http://dev.classmethod.jp/server-side/docker-server-side/docker-for-mac-shrink-image/",
        "post_date": "2017-04-03",
        "image_url": "http://cdn.dev.classmethod.jp/wp-content/uploads/2013/11/docker-320x320.png",
        "category": "Docker"
    },
    {
        "title": "JAWS-UG ECS Best Practice",
        "link": "http://www.slideshare.net/sudoyu/jawsug-ecs-best-practice",
        "post_date": "2017-03-31",
        "image_url": "https://cdn.slidesharecdn.com/ss_thumbnails/jaws-ugecsbestpractice-170330115536-thumbnail-4.jpg?cb=1490875438",
        "category": "Docker"
    },
    {
        "title": "Pythonで動かして学ぶ機械学習入門_予測モデルを作ってみよう",
        "link": "http://www.slideshare.net/ssuserb5817c/python-66169435",
        "post_date": "2017-03-31",
        "image_url": "https://cdn.slidesharecdn.com/ss_thumbnails/python1-160919131530-thumbnail-4.jpg?cb=1475043138",
        "category": "機械学習"
    },
    {
        "title": "DockerとDocker Hubの操作と概念",
        "link": "http://www.slideshare.net/zembutsu/docker-container-image-command-introduction-2017-03",
        "post_date": "2017-03-31",
        "image_url": "https://cdn.slidesharecdn.com/ss_thumbnails/dockercontainerimagecommandintroduction2017-03-170331100320-thumbnail-4.jpg?cb=1491404717",
        "category": "Docker"
    }
]
	``` 
