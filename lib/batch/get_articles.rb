require 'nokogiri'
#require 'hatena_bookmark_provider.rb'

class Batch::GetArticles
    #既に登録済みの記事かどうか
    def self.has_article?(link)
        Article.where(link: link).count == 0
    end

    def self.get_articles
        #カテゴリごとにイテレートする
        Category.select("category, source_url, id").each do|category|
            #各記事を取得
            hb_provider = Hb_provide_lib::Hatena_bookmark_provider.new(category.source_url)
            while hb_provider.has_next?
                article = hb_provider.next_item
                #記事以外のデータが混じるため、titleの有無でフィルタリング
                if article['title'] != nil
                    article['category_id'] = category.id
                    #未登録の記事かどうか
                    if has_article?(article['link']) 
                        puts "未登録記事です"                        
                        puts "title #{article['title']}"
                        puts "url #{article['link']}"
                        #データベースに保存
                        new_article = Article.new(article)
                        if new_article.save
                            puts "成功"
                        else
                            puts "失敗"
                        end
                    else
                        puts "登録済みです"
                        puts "title #{article['title']}"
                        puts "url #{article['link']}"
                    end
                end
            end
        end
    end
end

