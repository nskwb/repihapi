class Recipe < ApplicationRecord
  belongs_to :post

  validates :content, presence: true, length: { minimum: 1, maximum: 140 }
end
