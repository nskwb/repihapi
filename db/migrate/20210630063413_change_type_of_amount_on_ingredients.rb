class ChangeTypeOfAmountOnIngredients < ActiveRecord::Migration[6.1]
  def change
    change_column :ingredients, :amount, :string
  end
end
