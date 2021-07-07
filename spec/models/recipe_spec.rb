require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @post = create(:post)
    @recipe = build(:recipe, post_id: @post.id)
  end

  describe 'バリデーション' do
    it '各属性が正しい値の場合、有効である' do
      expect(@recipe).to be_valid
    end

    describe '説明文' do
      it '説明文がない場合、無効' do
        @recipe.content = nil
        @recipe.valid?
        expect(@recipe.errors[:content]).to include('を入力してください')
      end

      it '説明文が1文字のとき、有効' do
        @recipe.content = 'a'
        expect(@recipe).to be_valid
      end

      it '説明文が1文字より多く、140文字以下のとき、有効' do
        @recipe.content = 'a' * 70
        expect(@recipe).to be_valid
      end

      it '説明文が141文字以上のとき、無効' do
        @recipe.content = 'a' * 141
        @recipe.valid?
        expect(@recipe.errors[:content]).to include('は140文字以内で入力してください')
      end
    end
  end
end
