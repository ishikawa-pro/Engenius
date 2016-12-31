class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :link
      t.date :post_date
      t.references :category, foreign_key: true
      t.binary :image

      t.timestamps
    end
  end
end
