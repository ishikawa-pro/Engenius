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
### 立ち上げ方
``` ./initApp.sh``` でrailsコンテナとpostgresコンテナが立ち上がります。  
コンテナ停止させるときは、```docker-compose stop```  
コンテナを完全に落とす時は、``` docker-compose down ```
### APIリファレンス
APIの仕様について  
* **[GET]最新記事一覧**  
    カテゴリに関係なく、執筆日の新しい順に記事の情報を返します。  
    ##### Request URL  
    `http://localhost:3000/article.json[?limit][&offset]`  
    ##### Request parameters
    |param|description|
    |---|---|
    |limit(option) |何個の記事の情報を取得するかを指定できます。(指定しない場合全ての記事を返します)|
    |offset(option)|記事の情報を上から何個飛ばすか指定できます。|  
    #### Response(JSON)
    ```
	[
    {
        "title": "記事のタイトル",
        "link": "記事のURL",
        "post_date": "投稿された日",
        "image_url": "サムネイルのURL（ない場合は""）",
        "category": "カテゴリ"
    },
                    :
                    :
                    :
    ]
	```
* **[GET]特定のカテゴリの記事を取得**  
    指定したカテゴリの記事を新しい順に返します。  
    ##### request URL  
    `http://localhost:3000/article/show.josn[?category][&limit][&offset]`  
    ##### Request parameters  
    |param|description|
    |---|---|
    |category(require)|カテゴリを指定します。|
    |limit(option) |何個の記事の情報を取得するかを指定できます。(指定しない場合全ての記事を返します)|
    |offset(option)|記事の情報を上から何個飛ばすか指定できます。|  
    ##### Response(JSON)
    ```
	[
	{                                                      
	    "title": "記事のタイトル",
	    "link": "記事のURL",
	    "post_date": "投稿された日",
	    "image_url": "サムネイルのURL（ない場合は""）",
	    "category": "カテゴリ"
	},
	                :
	                :
	                :
	]
    ```
* **[GET]カテゴリーリストの取得**  
    カテゴリのリストを返します。  
    ##### request URL  
    `http://localhost:3000/article/categories.json`
    ##### Request parameters  
	なし  
    ##### Response(JSON)  
    ```
    [
    {
        "category": "カテゴリ"
    },
				  :
				  :
				  :
    ]
    ```
