require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  before do
    @user = create(:user)
    @user2 = create(:user)

    @user_post = create(:post, name: 'favorited_post', user: @user)
    @user_post2 = create(:post, name: 'favorited_post2', user: @user)

    sign_in @user2
  end

  describe 'POST /posts/:post_id/favorites' do
    it 'リクエストに成功すること' do
      post post_favorites_path(@user_post), xhr: true
      expect(response).to have_http_status(200)
    end

    it 'お気に入り数が１つ増えること' do
      expect do
        post post_favorites_path(@user_post), xhr: true
      end.to change(Favorite, :count).by(1)
    end
  end

  describe 'DELETE /posts/:post_id/favorites' do
    before do
      post post_favorites_path(@user_post), xhr: true
    end

    it 'リクエストに成功すること' do
      delete post_favorites_path(@user_post), xhr: true
      expect(response).to have_http_status(200)
    end

    it 'お気に入り数が１つ減ること' do
      expect do
        delete post_favorites_path(@user_post), xhr: true
      end.to change(Favorite, :count).by(-1)
    end
  end

  describe 'GET /users/:id/favorites' do
    before do
      create(:favorite, user: @user2, post: @user_post)
      create(:favorite, user: @user2, post: @user_post2)
    end

    it 'リクエストに成功すること' do
      get favorites_user_path(@user2)
      expect(response).to have_http_status(200)
    end

    it 'お気に入りした投稿が表示されていること' do
      get favorites_user_path(@user2)
      expect(response.body).to include('favorited_post')
      expect(response.body).to include('favorited_post2')
    end
  end
end
