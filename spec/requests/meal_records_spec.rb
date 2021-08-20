require 'rails_helper'

RSpec.describe 'MealRecords', type: :request do
  before do
    @user = create(:user)
    @post = create(:post, name: 'recorded_post', user: @user)
    sign_in @user
  end

  describe 'POST /posts/:post_id/meal_records' do
    it 'リクエストに成功すること' do
      post post_meal_records_path(@post), params: { meal_record: attributes_for(:meal_record, user: @user) }
      expect(response).to have_http_status(302)
    end

    it '食事記録の数が１つ増えること' do
      expect do
        post post_meal_records_path(@post), params: { meal_record: attributes_for(:meal_record, user: @user) }
      end.to change(MealRecord, :count).by(1)
    end

    it 'リダイレクトすること' do
      post post_meal_records_path(@post), params: { meal_record: attributes_for(:meal_record, user: @user) }
      expect(response).to redirect_to posts_path
    end
  end

  describe 'GET /users/:id/meal_records' do
    before do
      @post2 = create(:post, name: 'recorded_post2', user: @user)
      create(:meal_record, start_time: Time.zone.now, user: @user, post: @post, post_name: @post.name, post_protein: @post.protein, post_fat: @post.fat,
                           post_carbo: @post.carbo, post_calorie: @post.calorie)
      create(:meal_record, start_time: Time.zone.now, user: @user, post: @post2, post_name: @post2.name, post_protein: @post2.protein,
                           post_fat: @post2.fat, post_carbo: @post2.carbo, post_calorie: @post2.calorie)
    end

    it 'リクエストに成功すること' do
      get meal_records_user_path(@user)
      expect(response).to have_http_status(200)
    end

    it '食事記録が表示されていること' do
      get meal_records_user_path(@user)
      expect(response.body).to include('recorded_post')
      expect(response.body).to include('recorded_post2')
    end
  end
end
