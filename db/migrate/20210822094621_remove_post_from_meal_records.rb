class RemovePostFromMealRecords < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :meal_records, :posts
  end
end
