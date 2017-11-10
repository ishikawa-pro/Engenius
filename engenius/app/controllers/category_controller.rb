class CategoryController < ApplicationController
    def index
        @categories = Category.select(:category)
    end
end
