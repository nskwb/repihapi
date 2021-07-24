module NotificationsHelper
  def notification_info(notification)
    visitor = notification.visitor
    user_link = tag.a(visitor.name, href: user_path(visitor), class: 'text-xl font-bold text-green-600 underline')
    @post_link = tag.a('あなたの投稿', href: post_path(notification.post_id), class: 'text-green-600 font-bold underline') if notification.post_id
    @user_info = user_link + 'さんが'
    case notification.action
    when 'follow'
      @user_info + 'あなたをフォローしました'
    when 'favorite'
      @user_info + @post_link + 'をいいねしました'
    when 'comment'
      @comment = Comment.find_by(id: notification.comment_id)
      @user_info + @post_link + 'にコメントしました'
    end
  end
end
