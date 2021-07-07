require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it '各属性が正しい値の場合、有効である' do
      expect(@user).to be_valid
    end

    describe '名前' do
      it '名前がない場合、無効である' do
        @user.name = nil
        @user.valid?
        expect(@user.errors[:name]).to include('が入力されていません。')
      end

      it '名前が20文字以下の場合、有効である' do
        @user.name = 'a' * 20
        expect(@user).to be_valid
      end

      it '名前が21文字以上の場合、無効である' do
        @user.name = 'a' * 21
        expect(@user).to be_invalid
        expect(@user.errors[:name]).to include('は20文字以下に設定して下さい。')
      end
    end

    describe 'メールアドレス' do
      it 'メールアドレスがない場合、無効である' do
        @user.email = nil
        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include('が入力されていません。')
      end

      it '重複したメールアドレスがある場合、無効である' do
        create(:user, email: 'test@example.com')
        @another_user = build(:user, email: 'test@example.com')
        @another_user.valid?
        expect(@another_user.errors[:email]).to include('は既に使用されています。')
      end
    end

    describe 'パスワード' do
      it 'パスワードがない場合、無効である' do
        @user.password = nil
        @user.valid?
        expect(@user.errors[:password]).to include('が入力されていません。')
      end

      it 'パスワードが６文字以上の場合、有効である' do
        @user.password = 'a' * 6
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end

      it 'パスワードが5文字以下の場合、無効である' do
        @user.password = 'a' * 5
        @user.valid?
        expect(@user.errors[:password]).to include('は6文字以上に設定して下さい。')
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
