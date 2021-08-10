require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET /users/:id/follows' do
    it 'リクエストが成功すること' do
      get follows_user_url(@user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id/followers' do
    it 'リクエストが成功すること' do
      get followers_user_url(@user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users/:user_id/relationships' do
    before do
      @followed_user = create(:user)
    end

    it 'リクエストが成功すること' do
      post user_relationships_url(@followed_user), xhr: true
      expect(response).to have_http_status(200)
    end

    it 'フォロー数が１つ増えること' do
      expect do
        post user_relationships_url(@followed_user), xhr: true
      end.to change(Relationship, :count).by(1)
    end
  end

  describe 'DELETE /users/:user_id/relationships' do
    before do
      @followed_user = create(:user)
      post user_relationships_url(@followed_user), xhr: true
    end

    it 'リクエストが成功すること' do
      delete user_relationships_url(@followed_user), xhr: true
      expect(response).to have_http_status(200)
    end

    it 'フォロー数が１つ減ること' do
      expect do
        delete user_relationships_url(@followed_user), xhr: true
      end.to change(Relationship, :count).by(-1)
    end
  end
end
