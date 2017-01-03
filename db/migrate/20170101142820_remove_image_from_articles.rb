class RemoveImageFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :image, :byte
  end
end
