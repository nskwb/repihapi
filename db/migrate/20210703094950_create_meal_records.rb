class CreateMealRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :meal_records do |t|
      t.datetime :start_time, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
