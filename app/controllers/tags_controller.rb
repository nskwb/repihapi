class TagsController < ApplicationController
  before_action :set_q, only: %i[index search]
  def index
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').page(params[:page]).per(20)
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.page(params[:page]).per(16)
  end

  def search
    @tags = @q.result.page(params[:page]).per(20)
  end

  private

  def set_q
    @q = Tag.ransack(params[:q])
  end
end
