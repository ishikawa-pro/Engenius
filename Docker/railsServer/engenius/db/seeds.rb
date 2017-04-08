# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create(:category => "Docker", :source_url => "http://b.hatena.ne.jp/search/text?safe=on&q=Docker&users=25")
Category.create(:category => "機械学習", :source_url => "http://b.hatena.ne.jp/search/text?q=%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92&users=25")
Category.create(:category => "Swift", :source_url => "http://b.hatena.ne.jp/search/text?q=Swift&users=25")
Category.create(:category => "Ruby on Rails", :source_url => "http://b.hatena.ne.jp/search/text?q=Ruby+on+Rails&users=25")
