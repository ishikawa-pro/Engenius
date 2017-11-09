class ArticleController < ApplicationController
    def index
        #render text: 'index'        
        @articles = Article.select(:title, :link, :post_date,
                                   :image_url, :category_id)
                            .order(post_date: :desc)
                            .offset(params['offset']).limit(params['limit'])
    end

    def show
        @articles = Article.select(:title, :link, :post_date, :image_url,
                                   :category_id)
                    .joins(:category)
                    .merge(Category.where(category: params['category']))
                    .order(post_date: :desc)
                    .offset(params['offset']).limit(params['limit'])
    end

    def categories
        @categories = Category.select(:category)
    end
end
