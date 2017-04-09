# Engenius server
 Engeniusという技術ブログのニュースアプリのサーバーサイドです。  
 名前は技術者(Engineer)の賢い(Genius)情報収集アプリを目指しているので、  
Engineer + Genius = Engeniusです笑  
 はてなブックマークのブックマーク数の多い最新の記事をスクレイピングして
データベースに蓄え、Ruby on Railsを使ってJSONで記事の情報を返します。  

 最終的には機械学習などを利用して、人気のある記事をスクレイピングしていく仕様
にしていきたいです。  

## Description
* Rubyを使って各キーワード毎に、はてなブックマークで検索し一定以上のブックマー
ク数の記事を日付順にソートしてスクレイピングしています。  
ex) Docker: http://b.hatena.ne.jp/search/text?safe=on&q=Docker&users=50  
* バックエンドはRailsとPostgreSQLを利用しており、全てDockerで管理しています。
## Setup
Engeniusのサーバーを利用する前のセットアップの方法についてです。Makefileを使ってセットアップしていくようにしてい
ます。  
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

