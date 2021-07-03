class Ingredient < ApplicationRecord
  belongs_to :post

  validates :name, presence: true
  validates :amount, presence: true
end
