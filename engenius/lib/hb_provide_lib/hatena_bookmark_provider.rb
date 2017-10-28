require 'nokogiri'
require 'mechanize'
#require './html_provide_module.rb'

class Hb_provide_lib::Hatena_bookmark_provider 
    include Hb_provide_lib::HTML_provide_module 
    attr_reader :articles
    attr_accessor :index
    def initialize(url)
        #htmlをParseしてオブジェクトを作成
        docs=Hb_provide_lib::HTML_provide_module.get_html(url)
        #各記事の情報のみ収集
        @articles = docs.css('li')
        #記事のtitle, url, image, 執筆日を格納
        @article = Hash.new
        @index = 0
    end

    def has_next?
        @index < @articles.length
    end

    def next_item
        value = get_articles
        @index += 1
        value
    end

    #ogpからtitle,link,image_urlを取得
    def get_ogp(url)
        #targetをnokogiriへ渡す
        doc = Hb_provide_lib::HTML_provide_module.get_html(url) 
        if doc.nil?
            puts "エラーが発生したためスキップします"
            return false 
        end
        #metaタグからogpの内容を収集
        doc.css('meta').each do |meta|
            #title
            if  meta.attribute('property').to_s == "og:title"
                @article["title"] = meta.attribute('content').to_s
            #url
            elsif meta.attribute('property').to_s == "og:url"
                @article["link"] = meta.attribute('content').to_s
            #image
            elsif meta.attribute('property').to_s == "og:image"
                @article["image_url"] = meta.attribute('content').to_s 
            end
        end
        return true
    end
    protected :get_ogp

    def get_articles
        @article.clear
        doc = @articles[@index]
        #記事の情報を@articleに入れる.
        if  doc.css('h3').css('a').text != "" && doc.css('p').text == ""
            #日付を格納
            @article["post_date"] = doc.css('div').css('blockquote').css('span')[0].text
            #収集先のhtmlを取得
            self.get_ogp(doc.css('h3').css('a').attribute('href').value)
            if @article['title'] == nil || @article['link'] == nil
                #title
                @article["title"] = doc.css('h3').css('a').attribute('title').value
                #url
                puts "link: #{doc.css('h3').css('a').attribute('href').value}"
                @article["link"] = doc.css('h3').css('a').attribute('href').value
            end
        end
        if @article["title"] != nil
            #puts @article['title']
            #puts @article['link']
        end
        @article
    end
    protected :get_articles
end

