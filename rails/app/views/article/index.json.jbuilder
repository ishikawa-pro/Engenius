json.array!(@articles)  do |article|
    json.extract! article, :title, :link, :post_date, :image_url
    json.category article.category.category
end
