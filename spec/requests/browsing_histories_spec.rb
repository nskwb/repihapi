require 'rails_helper'

RSpec.describe 'BrowsingHistories', type: :request do
  before do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
    @user_post = create(:post, name: 'test_post', user: @user)
    @user2_post = create(:post, name: 'test_post2', user: @user2)
  end
  describe 'Create a browsing history' do
    it 'リクエストに成功すること' do
      get post_path @user2_post
      expect(response).to have_http_status(200)
    end

    it '閲覧履歴が１つ増えること' do
      expect do
        get post_path @user2_post
      end.to change(BrowsingHistory, :count).by(1)
    end
  end

  describe 'Destroy a browsing history' do
    before do
      # 閲覧履歴にある投稿に再度訪れた際は、古い履歴が消える
      get post_path @user2_post
      get post_path @user_post
    end

    it 'リクエストに成功すること' do
      get post_path @user2_post
      expect(response).to have_http_status(200)
    end

    it '古い履歴が消え、新しい履歴ができること' do
      expect do
        get post_path @user2_post
      end.not_to change(BrowsingHistory, :count)
    end
  end

  describe 'GET /users/:id/browsing_histories' do
    before do
      get post_path @user_post
      get post_path @user2_post
    end

    it 'リクエストに成功すること' do
      get browsing_histories_user_path @user
      expect(response).to have_http_status(200)
    end

    it '閲覧履歴が表示されていること' do
      get browsing_histories_user_path @user
      expect(response.body).to include('test_post')
      expect(response.body).to include('test_post2')
    end
  end
end
