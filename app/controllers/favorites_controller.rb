class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post_id: params[:post_id])
    favorite.save
    favorite.post.create_favorite_notification(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    favorite.destroy
  end
end
