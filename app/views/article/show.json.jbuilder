json.array!(@articles)  do |article|
    if article.image_url.nil?
        json.extract! article, :title, :link, :post_date
        json.image_url ""
        json.category article.category.category
    else
        json.extract! article, :title, :link, :post_date, :image_url
        json.category article.category.category
    end
end
