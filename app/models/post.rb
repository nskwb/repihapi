class Post < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
end
