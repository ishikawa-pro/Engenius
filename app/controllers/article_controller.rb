class ArticleController < ApplicationController
    def index
        #render text: 'index'
        created_data = Article.maximum('created_at')
        @articles = Article.where(created_at: created_data).select(:title, :link, :post_date, :image_url)
    end

    def show
        render text: 'show'
    end
end
