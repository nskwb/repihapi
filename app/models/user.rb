class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :image,
            file_size: {
              less_than: 5.megabytes
            },
            file_content_type: {
              allow: %w[image/jpg image/jpeg image/png]
            }

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  has_many :meal_records, dependent: :destroy
  has_many :recorded_posts, through: :meal_records, source: :post

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id, dependent: :destroy
  has_many :follows, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  has_many :active_notifications, class_name: 'Notification', foreign_key: :visitor_id, dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: :visited_id, dependent: :destroy

  has_many :browsing_histories, dependent: :destroy

  mount_uploader :image, ImageUploader

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

  def create_follow_notification(current_user)
    notification = current_user.active_notifications.build(visited_id: id, action: 'follow')
    notification.save if notification.valid?
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where('email = ?', data['email']).first
  end
end
