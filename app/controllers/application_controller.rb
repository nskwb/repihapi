class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email image image_cache])
  end

  private

  def calculate_nutrition
    count = @meal_records.length

    @average_protein = @meal_records.average(:post_protein).round
    @average_fat = @meal_records.average(:post_fat).round
    @average_carbo = @meal_records.average(:post_carbo).round
    @average_calorie = @meal_records.average(:post_calorie).round

    @total = @average_protein + @average_fat + @average_carbo
    @ratio_protein = (@average_protein / @total.to_f * 100).round
    @ratio_fat = (@average_fat / @total.to_f * 100).round
    @ratio_carbo = (@average_carbo / @total.to_f * 100).round

    @chart = [['P:タンパク質', @ratio_protein], ['F:脂肪', @ratio_fat], ['C:炭水化物', @ratio_carbo]]
  end
end
