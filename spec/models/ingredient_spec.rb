require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before do
    @post = create(:post)
    @ingredient = build(:ingredient, post_id: @post.id)
  end

  describe 'バリデーション' do
    it '各属性が正しい値の場合、有効' do
      expect(@ingredient).to be_valid
    end

    it '名前がない場合、無効' do
      @ingredient.name = nil
      @ingredient.valid?
      expect(@ingredient.errors[:name]).to include('を入力してください')
    end

    it '量がない場合、無効' do
      @ingredient.amount = nil
      @ingredient.valid?
      expect(@ingredient.errors[:amount]).to include('を入力してください')
    end
  end
end
