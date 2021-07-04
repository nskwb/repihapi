module UsersHelper
  def guest_user?
    current_user.email == 'guest@repihapi.com'
  end
end
