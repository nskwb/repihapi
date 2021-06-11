class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 50 }
  validates :image, file_size: { less_than: 5.megabytes },
                    file_content_type: { allow: ['image/jpg', 'image/jpeg', 'image/png'] }

  mount_uploader :image, ImageUploader

  def self.guest
    find_or_create_by!(email: 'guest@repihapi.com') do |user|
      user.name = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.zone.now
    end
  end
end
