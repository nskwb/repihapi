class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'

  validates :name, presence: true, length: { maximum:10 }
end
