class MealRecordsController < ApplicationController
  before_action :authenticate_user!

  def create
    start_time = Time.zone.now if params[:start_time].blank?
    meal_record = current_user.meal_records.build(start_time: start_time,
                                                  post_id: params[:post_id],
                                                  post_name: params[:post_name],
                                                  post_protein: params[:post_protein],
                                                  post_fat: params[:post_fat],
                                                  post_carbo: params[:post_carbo],
                                                  post_calorie: params[:post_calorie])
    meal_record.save
    flash[:success] = '食事記録に追加しました'
    redirect_to request.referer || posts_path
  end

  def destroy
    meal_record = MealRecord.find_by(user_id: current_user.id, post_id: params[:post_id], start_time: params[:start_time])
    meal_record.destroy
    flash[:success] = '食事記録を削除しました'
    redirect_to meal_records_user_path(current_user)
  end

  private

  def post_params
    params
      .require(:post)
      .permit(
        :name,
        :protein,
        :fat,
        :carbo,
        :calorie
      )
  end
end
