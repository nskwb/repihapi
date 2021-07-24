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

  def meal_records
    @start_date = params[:start_date].present? ? Time.zone.parse(params[:start_date]) : Time.zone.now
    @meal_records = current_user.meal_records.where(created_at: @start_date.all_month)

    if @meal_records.present?
      @posts = []
      counts = @meal_records.count
      @sum_protein = 0
      sum_fat = 0
      sum_carbo = 0
      sum_calorie = 0

      @meal_records.each_with_index do |meal_record, i|
        @posts[i] = Post.find(meal_record.post_id)
        @sum_protein += @posts[i].protein
        sum_fat += @posts[i].fat
        sum_carbo += @posts[i].carbo
        sum_calorie += @posts[i].calorie
      end
      @average_protein = (@sum_protein / counts).round
      @average_fat = (sum_fat / counts).round
      @average_carbo = (sum_carbo / counts).round
      @average_calorie = (sum_calorie / counts).round
    else
      render 'meal_records'
    end
  end

  def search
    @users = @q.result.page(params[:page]).per(10)
  end

  private

  def set_query
    @q = User.ransack(params[:q])
  end
end
