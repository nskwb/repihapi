class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_query, only: %i[index search]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(15)
  end

  def follows
    user = User.find(params[:id])
    @users = user.follows
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def favorites
    user = User.find(params[:id])
    @favorite_posts = user.favorite_posts
  end

  def search
    @users = @q.result.page(params[:page]).per(10)
  end

  private

  def set_query
    @q = User.ransack(params[:q])
  end
end
