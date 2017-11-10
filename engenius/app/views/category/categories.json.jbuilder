category = []
@categories.each do |elem|
    category.push(elem.category)
end
json.categories category
