class MealRecord < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :start_time, presence: true

  def post_name
    Post.find(post_id).name
  end
end
