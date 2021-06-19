class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @posts = Post.page(params[:page]).per(15)
  end

  def new
    @post = current_user.posts.build if user_signed_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿が作成されました'
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '投稿を更新しました'
      redirect_to post_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to request.referer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :image, :protein, :fat, :carbo, :calorie)
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to request.referer unless @post.user == current_user
  end
end
