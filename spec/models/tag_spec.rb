require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = build(:tag)
  end

  describe 'バリデーション' do
    it '名前がない場合、無効である' do
      @tag.name = nil
      @tag.valid?
      expect(@tag.errors[:name]).to include('を入力してください')
    end

    it '名前が1文字以上、10文字以下の場合、有効である' do
      expect(@tag).to be_valid
    end

    it '名前が11文字以上の場合、無効である' do
      @tag.name = 'a' * 11
      @tag.valid?
      expect(@tag.errors[:name]).to include('は10文字以内で入力してください')
    end
  end
end
