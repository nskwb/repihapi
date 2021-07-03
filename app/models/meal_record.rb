class MealRecord < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :start_time, presence :true
end
