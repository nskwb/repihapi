module NotificationsHelper
  def notification_info(notification)
    @visitor = notification.visitor
    @user_link = tag.a(@visitor.name, href: user_path(@visitor))
    @post_link = tag.a('あなたの投稿', href: post_path(notification.post_id)) if notification.post_id
    case notification.action
    when 'follow'
      "#{@user_link}さんがあなたをフォローしました"
    when 'favorite'
      "#{@user_link}さんが#{@post_link}をいいねしました"
    when 'comment'
      @comment = Comment.find_by(id: notification.comment_id)
      "#{@user_link}さんが#{@post_link}にコメントしました"
    end
  end
end
