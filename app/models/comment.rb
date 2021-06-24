class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  def create_comment_notification(current_user, comment_id)
    # コメントテーブルからpost_idカラムがコメントされた投稿のidのものであるレコードのuser_idカラムを取得する(select,where)
    # ただし、user_idカラムの値がコメント投稿者のidのレコードは除外する(where.not)
    # また、重複したuser_idは削除し、一意であるようにする(distinct)
    temp_ids = Comment.select(:user_id).where('post_id = ?', id).where.not('user_id = ?',
                                                                           current_user.id)
    # byebug入れて動作確認必要
    if temp_ids.present?
      temp_ids.each do |temp_id|
        save_comment_notification(current_user, comment_id, temp_id['user_id'])
      end
    else
      save_comment_notification(current_user, comment_id, user_id)
    end
  end

  private

  def save_comment_notification(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.build(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
