class Ingredient < ApplicationRecord
  belongs_to :post

  validates :name, presence: true
  validates :name, presence: true

end
