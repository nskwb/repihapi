require 'rails_helper'

RSpec.describe "Tags", type: :request do
  before do
    @user = create(:user)
    @post = create(:post)

    @tag = create(:tag, name: 'test_tag')
    @tag2 = create(:tag, name: 'test_tag2')

    @post_tag1 = create(:post_tag, post: @post, tag: @tag)
    @post_tag2 = create(:post_tag, post: @post, tag: @tag2)

    sign_in @user
  end

  describe "GET /tags" do
    it "リクエストに成功する" do
      get tags_path
      expect(response).to have_http_status(200)
    end

    it 'タグ名が表示されていること' do
      get tags_path
      expect(response.body).to include('test_tag')
      expect(response.body).to include('test_tag2')
    end
  end

end
