require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @user = create(:user)
    @user2 = create(:user)
    @user2_post = create(:post, user: @user2)
    sign_in @user
  end

  describe 'POST /posts/:post_id/comments' do
    context 'パラメータが妥当な場合' do
      it 'リクエストに成功すること' do
        post post_comments_path(@user2_post), params: { comment: attributes_for(:comment) }
        expect(response).to have_http_status(302)
      end

      it 'コメント数が１つ増えること' do
        expect do
          post post_comments_path(@user2_post), params: { comment: attributes_for(:comment) }
        end.to change(Comment, :count).by(1)
      end

      it '投稿詳細ページにリダイレクトすること' do
        post post_comments_path(@user2_post), params: { comment: attributes_for(:comment) }
        expect(response).to redirect_to post_path(@user2_post)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストに成功すること' do
        post post_comments_path(@user2_post), params: { comment: attributes_for(:comment, content: nil) }
        expect(response).to have_http_status(200)
      end

      it 'コメント数が変化しないこと' do
        expect do
          post post_comments_path(@user2_post), params: { comment: attributes_for(:comment, content: nil) }
        end.not_to change(Comment, :count)
      end
    end
  end
end
