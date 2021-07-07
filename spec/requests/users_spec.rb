require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'ログイン前' do
    before do
      @user = build(:user, confirmed_at: nil)
    end

    describe '新規登録' do
      it 'リクエストが成功すること' do
        get new_user_registration_path
        expect(response.status).to eq 200
      end
    end

    describe '作成' do
      before do
        ActionMailer::Base.deliveries.clear
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          post user_registration_path, params: { user: attributes_for(:user) }
          expect(response.status).to eq 302
        end

        it '認証メールが送信されること' do
          post user_registration_path, params: { user: attributes_for(:user) }
          expect(ActionMailer::Base.deliveries.size).to eq 1
        end

        it '作成が成功すること' do
          expect do
            post user_registration_path, params: { user: attributes_for(:user) }
          end.to change(User, :count).by 1
        end

        it 'ルートにリダイレクトされること' do
          post user_registration_path, params: { user: attributes_for(:user) }
          expect(response).to redirect_to root_path
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          post user_registration_path, params: { user: attributes_for(:user, name: '') }
          expect(response.status).to eq 200
        end

        it '認証メールが送信されないこと' do
          post user_registration_path, params: { user: attributes_for(:user, name: '') }
          expect(ActionMailer::Base.deliveries.size).to eq 0
        end

        it '作成が失敗すること' do
          expect do
            post user_registration_path, params: { user: attributes_for(:user, name: '') }
          end.not_to change(User, :count)
        end

        it 'エラーが表示されること' do
          post user_registration_path, params: { user: attributes_for(:user, name: '') }
          expect(response.body).to include('error_explanation')
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      @user = create(:user, name: 'test_user', email: 'test@example.com')
      sign_in @user
    end

    describe '一覧' do
      before do
        @user2 = create(:user, name: 'test_user2')
      end

      it 'リクエストが成功すること' do
        get users_path
        expect(response).to have_http_status(200)
      end

      it 'ユーザー名が表示されていること' do
        get users_path
        expect(response.body).to include('test_user')
        expect(response.body).to include('test_user2')
      end
    end

    describe '詳細' do
      context 'ユーザーが存在する場合' do
        it 'リクエストが成功すること' do
          get user_path @user.id
          expect(response).to have_http_status(200)
        end

        it 'ユーザー名が表示されていること' do
          get user_path @user.id
          expect(response.body).to include('test_user')
        end
      end

      context 'ユーザーが存在しない場合' do
        subject { -> { get user_url 999 } }

        it { is_expected.to raise_error ActiveRecord::RecordNotFound }
      end
    end

    describe '編集' do
      it 'リクエストが成功すること' do
        get edit_user_registration_path @user
        expect(response.status).to eq 200
      end

      it 'ユーザーの情報が表示されていること' do
        get edit_user_registration_path @user
        expect(response.body).to include('test_user')
        expect(response.body).to include('test@example.com')
      end
    end

    describe '更新' do
      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          put user_registration_path, params: { user: attributes_for(:user, name: 'updated_test_user') }
          expect(response.status).to eq 302
        end

        it 'ユーザー名が更新されること' do
          expect do
            put user_registration_path, params: { user: attributes_for(:user, name: 'updated_test_user') }
          end.to change { User.find(@user.id).name }.from('test_user').to('updated_test_user')
        end

        it 'リダイレクトすること' do
          put user_registration_path, params: { user: attributes_for(:user, name: 'updated_test_user') }
          expect(response).to redirect_to user_path @user
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          put user_registration_path, params: { user: attributes_for(:user, name: '') }
          expect(response.status).to eq 200
        end

        it 'ユーザー名が変更されないこと' do
          expect do
            put user_registration_path, params: { user: attributes_for(:user, name: '') }
          end.not_to change(User.find(@user.id), :name)
        end
      end
    end

    describe '削除' do
      it 'リクエストが成功すること' do
        delete user_registration_path
        expect(response.status).to eq 302
      end

      it 'ユーザーが削除されること' do
        expect do
          delete user_registration_path
        end.to change(User, :count).by(-1)
      end

      it 'ルートにリダイレクトすること' do
        delete user_registration_path
        expect(response).to redirect_to root_path
      end
    end
  end
end
