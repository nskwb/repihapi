module UsersHelper
  meal_record = nil

  def guest_user?
    current_user.email == 'guest@repihapi.com'
  end

  def meal_record_present?(arg)
    meal_record = Post.find_by(id: arg.post_id)
    meal_record.present?
  end
end
