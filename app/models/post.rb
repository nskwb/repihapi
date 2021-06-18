class Post < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :image, file_size: { less_than: 5.megabytes },
                    file_content_type: { allow: ['image/jpg', 'image/jpeg', 'image/png'] }

  mount_uploader :image, ImageUploader
end