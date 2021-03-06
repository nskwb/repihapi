require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before { @user = create(:user) }

  describe 'ログイン必須' do
    let(:image) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/default_post_image.jpeg'), 'image/jpeg') }

    before { sign_in @user }

    describe 'GET #new' do
      it 'リクエストが成功すること' do
        get new_post_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST #create' do
      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          post posts_url,
               params: {
                 post:
                   attributes_for(:post, image: image)
                     .merge(ingredients_attributes: [attributes_for(:ingredient)])
                     .merge(recipes_attributes: [attributes_for(:recipe)])
               }

          expect(response).to have_http_status(302)
        end

        it '作成が成功すること' do
          expect do
            post posts_url,
                 params: {
                   post:
                     attributes_for(:post, image: image)
                       .merge(ingredients_attributes: [attributes_for(:ingredient)])
                       .merge(recipes_attributes: [attributes_for(:recipe)])
                 }
          end.to change(Post, :count).by(1).and change(Ingredient, :count).by(1).and change(Recipe, :count).by(1)
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          post posts_url, params: { post: attributes_for(:post, name: '') }
          expect(response).to have_http_status(200)
        end

        it '作成が失敗すること' do
          expect { post posts_url, params: { post: attributes_for(:post, name: '') } }.not_to change(Post, :count)
        end
      end
    end

    describe '投稿者のみ操作可能' do
      before do
        @post = create(:post, name: 'post_name', user: @user)
        @ingredient = create(:ingredient, post: @post)
        @recipe = create(:recipe, post: @post)
      end

      describe 'GET #edit' do
        it 'リクエストが成功すること' do
          get edit_post_path @post.id
          expect(response).to have_http_status(200)
        end

        it '投稿の情報が表示されていること' do
          get edit_post_path @post.id
          expect(response.body).to include('post_name')
        end
      end

      describe 'DELETE #destroy' do
        it 'リクエストが成功すること' do
          delete post_path @post
          expect(response).to have_http_status(302)
        end

        it '投稿が削除されること' do
          expect { delete post_path @post }.to change(Post, :count).by(-1)
        end

        it 'リダイレクトすること' do
          delete post_path @post
          expect(response).to redirect_to @post.user
        end
      end
    end
  end

  describe 'ログインなしでも閲覧可' do
    before { @post = create(:post, name: 'test_post') }
    describe 'GET #index' do
      before { @post2 = create(:post, name: 'test_post2') }

      it 'リクエストが成功すること' do
        get posts_path
        expect(response).to have_http_status(200)
      end

      it '投稿名が表示されていること' do
        get posts_path
        expect(response.body).to include('test_post')
        expect(response.body).to include('test_post2')
      end
    end

    describe 'GET #show' do
      before { sign_in @user }
      context '投稿が存在する場合' do
        it 'リクエストが成功すること' do
          get post_path @post
          expect(response).to have_http_status(200)
        end
        it '投稿名が表示されていること' do
          get post_path @post.id
          expect(response.body).to include('test_post')
        end
      end

      context '投稿が存在しない場合' do
        it '食事記録ページにリダイレクト' do
          get post_path(id: 0)
          expect(response).to redirect_to meal_records_user_path(@user)
        end
      end
    end
  end
end
