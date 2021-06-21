class AddIndexFollowingIdAndFollowerIdOnRelationships < ActiveRecord::Migration[6.1]
  def change
    add_index :relationships, [:following_id, :follower_id], unique: true
  end
end
