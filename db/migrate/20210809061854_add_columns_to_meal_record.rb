class AddColumnsToMealRecord < ActiveRecord::Migration[6.1]
  def change
    add_column :meal_records, :post_name, :string
    add_column :meal_records, :post_protein, :float
    add_column :meal_records, :post_fat, :float
    add_column :meal_records, :post_carbo, :float
    add_column :meal_records, :post_calorie, :integer
  end
end
