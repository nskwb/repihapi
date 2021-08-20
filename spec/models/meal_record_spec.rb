require 'rails_helper'

RSpec.describe MealRecord, type: :model do
  before do
    @user = create(:user)
    @post = create(:post)
    @meal_record = build(:meal_record, start_time: Time.zone.now, user_id: @user.id, post_id: @post.id, post_name: @post.name, post_protein: @post.protein, post_fat: @post.fat, post_carbo: @post.carbo, post_calorie: @post.calorie)
  end

  describe 'バリデーション' do
    it '各属性が正しい値の場合、有効である' do
      expect(@meal_record).to be_valid
    end

    it '登録日時がない場合、無効である' do
      @meal_record.start_time = nil
      @meal_record.valid?
      expect(@meal_record.errors[:start_time]).to include('を入力してください')
    end
  end
end
