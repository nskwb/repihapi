class FixColumnsOnPostsAndIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :serve, :integer, null: false

    remove_column :ingredients, :serve
  end
end
