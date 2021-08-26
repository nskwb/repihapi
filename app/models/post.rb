class Post < ApplicationRecord
  HISTORY_LIMIT = 20

  belongs_to :user

  has_many :ingredients, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :notifications, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy

  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipes, allow_destroy: true

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :image, presence: true,
                    file_size: { less_than: 5.megabytes },
                    file_content_type: {
                      allow: %w[image/jpg image/jpeg image/png]
                    }
  validates :serve, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :protein, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fat, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :carbo, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :calorie, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  mount_uploader :image, ImageUploader

  def favorited_by?(user)
    favorites.where('user_id = ?', user.id).exists?
  end

  def save_tags(posted_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - posted_tags
    new_tags = posted_tags - current_tags
    old_tags.each { |old_tag_name| tags.delete Tag.find_by(name: old_tag_name) }

    new_tags.each do |new_tag_name|
      post_tag = Tag.find_or_create_by(name: new_tag_name)
      tags << post_tag
    end
  end

  def create_favorite_notification(current_user)
    temp =
      Notification.where(
        ['visitor_id = ? and visited_id = ? and post_id = ? and action = ?', current_user.id, user_id, id, 'favorite']
      )
    if temp.blank?
      notification = current_user.active_notifications.build(post_id: id, visited_id: user_id, action: 'favorite')
      notification.save if notification.valid?
    end
  end

  def create_comment_notification(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where('post_id = ?', id).where.not('user_id = ?', current_user.id)

    if temp_ids.present?
      temp_ids.each { |temp_id| save_comment_notification(current_user, comment_id, temp_id['user_id']) }
    else
      save_comment_notification(current_user, comment_id, user_id)
    end
  end

  def save_browsing_history(current_user)
    new_history = browsing_histories.new
    new_history.user_id = current_user.id
    if current_user.browsing_histories.exists?(post_id: id)
      old_history = current_user.browsing_histories.find_by(post_id: id)
      old_history.destroy
    end
    new_history.save

    histories = current_user.browsing_histories.all
    histories[0].destroy if histories.count > HISTORY_LIMIT
  end

  private

  def save_comment_notification(current_user, comment_id, visited_id)
    notification =
      current_user.active_notifications.build(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
