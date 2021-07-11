class MealRecordsController < ApplicationController
  before_action :authenticate_user!

  def create
    start_time = Time.zone.now
    meal_record = current_user.meal_records.build(start_time: start_time, post_id: params[:post_id])
    meal_record.save
    redirect_to posts_path
  end

  def destroy
    meal_record = MealRecord.find_by(user_id: current_user.id, post_id: params[:post_id])
    meal_record.destroy
    redirect_to meal_records_user_path(current_user)
  end
end
