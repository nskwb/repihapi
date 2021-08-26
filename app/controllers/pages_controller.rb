class PagesController < ApplicationController
  def index
    @popular_posts = Post.includes(:user).unscope(:order).find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @latest_posts = Post.includes(:user).order(created_at: :desc).limit(5)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').limit(30)

    if user_signed_in?
      @start_date = params[:start_date].present? ? Time.zone.parse(params[:start_date]) : Time.zone.now
      @meal_records = current_user.meal_records.where(created_at: @start_date.all_month)
      @following_posts = Post.includes(:user).where(user_id: [current_user.follows]).limit(3)
      calculate_nutrition if @meal_records.present?
    end
  end
end
