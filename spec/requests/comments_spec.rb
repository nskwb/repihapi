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
        post post_comments_path(@user2_post), params: { comment: attributes_for(:comment) }, xhr: true
        expect(response).to have_http_status(200)
      end

      it 'コメント数が１つ増えること' do
        expect do
          post post_comments_path(@user2_post), params: { comment: attributes_for(:comment) }, xhr: true
        end.to change(Comment, :count).by(1)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストに成功すること' do
        post post_comments_path(@user2_post), params: { comment: attributes_for(:comment, content: nil) }, xhr: true
        expect(response).to have_http_status(200)
      end

      it 'コメント数が変化しないこと' do
        expect do
          post post_comments_path(@user2_post), params: { comment: attributes_for(:comment, content: nil) }, xhr: true
        end.not_to change(Comment, :count)
      end
    end
  end

  describe 'DELETE /posts/:post_id/comments/:id' do
    before { @comment = create(:comment, user: @user, post: @user2_post) }

    context '自分のコメントの場合' do
      it 'リクエストに成功すること' do
        delete post_comment_path(@user2_post, @comment), xhr: true
        expect(response).to have_http_status(200)
      end

      it 'コメント数が一つ減ること' do
        expect { delete post_comment_path(@user2_post, @comment), xhr: true }.to change(Comment, :count).by(-1)
      end
    end
  end
end
