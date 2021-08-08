class CreateBrowsingHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :browsing_histories do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :post, null: false, foreign_key: true, index: false

      t.timestamps
    end

    add_index :browsing_histories, [:user_id, :post_id], unique: true
  end
end
