class AddColumnsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :protein, :float, null: false
    add_column :posts, :fat, :float, null: false
    add_column :posts, :carbo, :float, null: false
    add_column :posts, :calorie, :integer, null: false

  end
end
