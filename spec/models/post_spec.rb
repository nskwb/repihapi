require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = create(:user)
    @post = build(:post, user_id: @user.id)
  end

  describe 'バリデーション' do
    it '名前・説明文・画像・タンパク質・脂肪・炭水化物・カロリー・分量・user_idがある場合、有効である' do
      expect(@post).to be_valid
    end

    context '名前' do
      it '名前がない場合、無効である' do
        @post.name = nil
        @post.valid?
        expect(@post.errors[:name]).to include('を入力してください')
      end

      it '名前が50文字以下の場合、有効である' do
        @post.name = 'a' * 50
        expect(@post).to be_valid
      end

      it '名前が51文字以上の場合、無効である' do
        @post.name = 'a' * 51
        @post.valid?
        expect(@post.errors[:name]).to include('は50文字以内で入力してください')
      end

      it '重複した名前がある場合、無効である' do
        create(:post, name: 'test')
        @another_post = build(:post, name: 'test')
        @another_post.valid?
        expect(@another_post.errors[:name]).to include('はすでに存在します')
      end
    end

    context '説明文' do
      it '説明文がない場合、無効である' do
        @post.content = nil
        @post.valid?
        expect(@post.errors[:content]).to include('を入力してください')
      end

      it '説明文が200文字以下の場合、有効である' do
        @post.content = 'a' * 200
        expect(@post).to be_valid
      end

      it '説明文が201文字以上の場合、無効である' do
        @post.content = 'a' * 201
        @post.valid?
        expect(@post.errors[:content]).to include('は200文字以内で入力してください')
      end
    end

    context 'タンパク質' do
      it 'タンパク質がない場合、無効である' do
        @post.protein = nil
        @post.valid?
        expect(@post.errors[:protein]).to include('を入力してください')
      end

      it 'タンパク質が0の場合、有効である' do
        @post.protein = 0
        expect(@post).to be_valid
      end

      it 'タンパク質が0より大きい場合、有効である' do
        @post.protein = 0.1
        expect(@post).to be_valid
      end

      it 'タンパク質が0未満の場合、無効である' do
        @post.protein = -0.1
        @post.valid?
        expect(@post.errors[:protein]).to include('は0以上の値にしてください')
      end
    end

    context '脂肪' do
      it '脂肪がない場合、無効である' do
        @post.fat = nil
        @post.valid?
        expect(@post.errors[:fat]).to include('を入力してください')
      end

      it '脂肪が0の場合、有効である' do
        @post.fat = 0
        expect(@post).to be_valid
      end

      it '脂肪が0より大きい場合、有効である' do
        @post.fat = 0.1
        expect(@post).to be_valid
      end

      it '脂肪が0未満の場合、無効である' do
        @post.fat = -0.1
        @post.valid?
        expect(@post.errors[:fat]).to include('は0以上の値にしてください')
      end
    end

    context '炭水化物' do
      it '炭水化物がない場合、無効である' do
        @post.carbo = nil
        @post.valid?
        expect(@post.errors[:carbo]).to include('を入力してください')
      end

      it '炭水化物が0の場合、有効である' do
        @post.carbo = 0
        expect(@post).to be_valid
      end

      it '炭水化物が0より大きい場合、有効である' do
        @post.carbo = 0.1
        expect(@post).to be_valid
      end

      it '炭水化物が0未満の場合、無効である' do
        @post.carbo = -0.1
        @post.valid?
        expect(@post.errors[:carbo]).to include('は0以上の値にしてください')
      end
    end

    context 'カロリー' do
      it 'カロリーがない場合、無効である' do
        @post.calorie = nil
        @post.valid?
        expect(@post.errors[:calorie]).to include('を入力してください')
      end

      it 'カロリーが0の場合、有効である' do
        @post.calorie = 0
        expect(@post).to be_valid
      end

      it 'カロリーが0より大きい場合、有効である' do
        @post.calorie = 1
        expect(@post).to be_valid
      end

      it 'カロリーが0未満の場合、無効である' do
        @post.calorie = -1
        @post.valid?
        expect(@post.errors[:calorie]).to include('は0以上の値にしてください')
      end

      it 'カロリーが小数の場合、無効である' do
        @post.calorie = 0.1
        @post.valid?
        expect(@post.errors[:calorie]).to include('は整数で入力してください')
      end
    end

    context '分量' do
      it '分量がない場合、無効である' do
        @post.serve = nil
        @post.valid?
        expect(@post.errors[:serve]).to include('を入力してください')
      end

      it '分量が1の場合、有効である' do
        @post.serve = 1
        expect(@post).to be_valid
      end

      it '分量が1より大きい場合、有効である' do
        @post.serve = 2
        expect(@post).to be_valid
      end

      it '分量が1未満の場合、無効である' do
        @post.serve = 0
        @post.valid?
        expect(@post.errors[:serve]).to include('は1以上の値にしてください')
      end
    end

    context 'ユーザーid' do
      it 'ユーザーidがない場合、無効である' do
        @post.user_id = nil
        @post.valid?
        expect(@post.errors[:user_id]).to include('を入力してください')
      end
    end

    context '画像' do
      it '画像がない場合、無効である' do
        @post.image = nil
        @post.valid?
        expect(@post.errors[:image]).to include('を入力してください')
      end
    end
  end
end
