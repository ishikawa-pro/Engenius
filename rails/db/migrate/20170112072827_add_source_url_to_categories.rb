class AddSourceUrlToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :source_url, :string
  end
end
