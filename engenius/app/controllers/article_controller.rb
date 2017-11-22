class ArticleController < ApplicationController
    def index
        #render text: 'index'        
        @articles = Article.select(:title, :link, :post_date,
                                   :image_url, :category_id)
                            .order(post_date: :desc)
                            .offset(params['offset']).limit(params['limit'])
    end

    def show
        @articles = Category.joins(:articles)
                    .select("categories.category, articles.*")
                    .where(category: params['category'])
                    .order("articles.post_date desc")
                    .offset(params['offset'])
                    .limit(params['limit'])
    end
end
