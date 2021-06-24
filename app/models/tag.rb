class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 }
end
