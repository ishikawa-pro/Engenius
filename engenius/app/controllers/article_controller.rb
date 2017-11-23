class ArticleController < ApplicationController
    def index
        p params['category']
        @articles = Category.joins(:articles)
                    .select("categories.category, articles.*")
                    .where(category: params['category'])
                    .order("articles.post_date desc, id")
                    .offset(params['offset'])
                    .limit(params['limit'])
    end

    def show
        @articles = Category.joins(:articles)
                    .select("categories.category, articles.*")
                    .where(category: params['category'])
                    .order("articles.post_date desc, id")
                    .offset(params['offset'])
                    .limit(params['limit'])
    end
end
