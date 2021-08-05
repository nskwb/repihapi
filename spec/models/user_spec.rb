require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = build(:user) }

  describe 'バリデーション' do
    it '各属性が正しい値の場合、有効である' do
      expect(@user).to be_valid
    end

    describe '名前' do
      it '名前がない場合、無効である' do
        @user.name = nil
        @user.valid?
        expect(@user.errors[:name]).to include('を入力してください')
      end

      it '名前が15文字以下の場合、有効である' do
        @user.name = 'a' * 100
        expect(@user).to be_valid
      end

      it '名前が16文字以上の場合、無効である' do
        @user.name = 'a' * 16
        expect(@user).to be_invalid
        expect(@user.errors[:name]).to include('は15文字以内で入力してください')
      end
    end

    describe 'メールアドレス' do
      it 'メールアドレスがない場合、無効である' do
        @user.email = nil
        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include('を入力してください')
      end

      it '重複したメールアドレスがある場合、無効である' do
        create(:user, email: 'test@example.com')
        @another_user = build(:user, email: 'test@example.com')
        @another_user.valid?
        expect(@another_user.errors[:email]).to include('はすでに存在します')
      end
    end

    describe 'パスワード' do
      it 'パスワードがない場合、無効である' do
        @user.password = nil
        @user.valid?
        expect(@user.errors[:password]).to include('を入力してください')
      end

      it 'パスワードが６文字以上の場合、有効である' do
        @user.password = 'a' * 6
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end

      it 'パスワードが5文字以下の場合、無効である' do
        @user.password = 'a' * 5
        @user.valid?
        expect(@user.errors[:password]).to include('は6文字以上で入力してください')
      end

      it 'パスワードと確認用パスワードの値が違う場合、無効である' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end

    describe '画像' do
      it '画像がなくても有効である' do
        @user.image = nil
        expect(@user).to be_valid
      end
    end
  end
end
