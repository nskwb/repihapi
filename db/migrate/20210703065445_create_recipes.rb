class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.text :content, null: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
