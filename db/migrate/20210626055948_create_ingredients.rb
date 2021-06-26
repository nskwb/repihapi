class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.integer :serve, null: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
