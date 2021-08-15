class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_query, only: %i[index search]

  def index
    @users = User.page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(6)
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

  def meal_records
    @start_date = params[:start_date].present? ? Time.zone.parse(params[:start_date]) : Time.zone.now
    @meal_records = current_user.meal_records.where(created_at: @start_date.all_month)

    if @meal_records.present?
      count = @meal_records.length

      @average_protein = @meal_records.average(:post_protein).round
      @average_fat = @meal_records.average(:post_fat).round
      @average_carbo = @meal_records.average(:post_carbo).round
      @average_calorie = @meal_records.average(:post_calorie).round

      @total = @average_protein + @average_fat + @average_carbo
      @ratio_protein = (@average_protein / @total.to_f * 100).round
      @ratio_fat = (@average_fat / @total.to_f * 100).round
      @ratio_carbo = (@average_carbo / @total.to_f * 100).round
    else
      render 'meal_records'
    end
  end

  def browsing_histories
    @browsing_histories = current_user.browsing_histories.includes(:post)
  end

  def search
    @users = @q.result.page(params[:page]).per(10)
  end

  private

  def set_query
    @q = User.ransack(params[:q])
  end
end
