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
      # current_user.calculate_nutrients(@meal_records)
      sum_protein = 0
      sum_fat = 0
      sum_carbo = 0
      sum_calorie = 0

      counts = @meal_records.count
      @meal_records.each do |meal_record|
        sum_protein += meal_record.post_protein
        sum_fat += meal_record.post_fat
        sum_carbo += meal_record.post_carbo
        sum_calorie += meal_record.post_calorie
      end
      @average_protein = (sum_protein / counts).round
      @average_fat = (sum_fat / counts).round
      @average_carbo = (sum_carbo / counts).round
      @average_calorie = (sum_calorie / counts).round

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
