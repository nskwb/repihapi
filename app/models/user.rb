class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 50 }
  validates :image, file_size: { less_than: 5.megabytes },
                    file_content_type: { allow: ['image/jpg', 'image/jpeg', 'image/png'] }

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_tweets, through: :favorites, source: :post

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :follows, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  mount_uploader :image, ImageUploader

  # 引数のユーザーがレシーバーのユーザーをフォローしているかどうか判別する
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.guest
    find_or_create_by!(email: 'guest@repihapi.com') do |user|
      user.name = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.zone.now
    end
  end
end
