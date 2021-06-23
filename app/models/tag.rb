class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum:10 }
end
