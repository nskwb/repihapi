class ChangeColumnsOnPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :name, false
    change_column_null :posts, :content, false
  end
end
