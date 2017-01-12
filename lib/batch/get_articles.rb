require 'nokogiri'
#require 'hatena_bookmark_provider.rb'

class Batch::GetArticles
    def self.get_articles
        url = 'http://b.hatena.ne.jp/search/title?safe=on&q=docker&users=50'
        hb_provider = Hb_provide_lib::Hatena_bookmark_provider.new(url)
        p Category.all
        while hb_provider.has_next?
            article = hb_provider.next_item
            #記事以外のデータが混じるため、titleの有無でフィルタリング
            if article['title'] != nil
                puts article['title']
            end
        end
    end
end

