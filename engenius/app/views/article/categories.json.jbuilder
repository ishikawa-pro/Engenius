json.array!(@articles) do |article|
    json.category article.category
end
