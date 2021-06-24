class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true, uniqueness: { scope: :user_id }

  def create_favorite_notification
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ?', current_user.id,
                               user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.build(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      notification.save if notification.valid?
    end
  end
end
