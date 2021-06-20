class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    favorite.save
    redirect_to posts_path
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    favorite.destroy
    redirect_to request.referer
  end
end
