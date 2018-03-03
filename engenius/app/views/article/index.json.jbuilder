json.array!(@articles)  do |article|
    json.extract! article, :title, :post_date
    json.url URI.encode(article.link)
    if article.image_url.nil?
        json.image_url nil
    else
        json.image_url URI.encode(article.image_url)
    end
    json.category article.category
end
