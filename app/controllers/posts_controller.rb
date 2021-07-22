class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :set_query, only: %i[index search]

  def index
    @posts = Post.page(params[:page]).per(15)
  end

  def new
    @post = current_user.posts.build
    @ingredient = @post.ingredients.build
    @recipe = @post.recipes.build
  end

  def create
    params[:post][:image] = 'thumb_default_post_image.jpeg' if params[:post][:image].blank?
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:tag_names].split(',') if params[:post][:tag_names].present?
    if @post.save
      @post.save_tags(tag_list) if tag_list.present?
      flash[:success] = '投稿が作成されました'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build if user_signed_in?
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])

    # フォームのタグの部分に初期値として代入する
    @tags = @post.tags.pluck(:name).join(',') if @post.tags.present?
  end

  def update
    @post = Post.find(params[:id])

    params[:post][:image] = 'thumb_default_post_image.jpeg' if params[:post][:image].blank?

    tag_list = params[:post][:tag_names].split(',') if params[:post][:tag_names].present?
    if @post.update(post_params)
      @post.save_tags(tag_list) if tag_list.present?
      flash[:success] = '投稿を更新しました'
      redirect_to post_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to root_url
  end

  def search
    @posts = @q.result.page(params[:page]).per(15)
  end

  private

  def post_params
    params
      .require(:post)
      .permit(
        :name,
        :content,
        :image,
        :serve,
        :protein,
        :fat,
        :carbo,
        :calorie,
        ingredients_attributes: %i[id name amount post_id _destroy],
        recipes_attributes: %i[id content post_id _destroy]
      )
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to request.referer || root_path unless @post.user == current_user
  end

  def set_query
    @q = Post.ransack(params[:q])
  end
end
