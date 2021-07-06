require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = create(:user)
    @post = create(:post)
    @comment = build(:comment, user_id: @user.id, post_id: @post.id)
  end

  describe 'バリデーション' do
    it '内容がない場合、無効である' do
      @comment.content = nil
      @comment.valid?
      expect(@comment.errors[:content]).to include('を入力してください')
    end

    it '内容が1文字以上、100文字以下の場合、有効である' do
      expect(@comment).to be_valid
    end

    it '内容が101文字以上の場合、無効である' do
      @comment.content = 'a' * 101
      @comment.valid?
      expect(@comment.errors[:content]).to include('は100文字以内で入力してください')
    end
  end
end
