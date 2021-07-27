class PagesController < ApplicationController
  def index
    @popular_posts = Post.unscope(:order).find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @latest_posts = Post.order(created_at: :desc).limit(5)
    @popular_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').limit(20)
  end
end
