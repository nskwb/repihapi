require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前・メールアドレス・パスワード・確認用パスワードがある場合、有効である" do
    user = User.new(
      name: "RSpec Test",
      email: "test@example.com",
      password: "password"
    )
    expect(user).to be_valid
  end
  it "名前がない場合、無効である" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("が入力されていません。")
  end
  it "名前が20文字以下の場合、有効である"
  it "名前が21文字以上の場合、無効である"
  it "メールアドレスがない場合、無効である"
  it "重複したメールアドレスがある場合、無効である" do
    User.create(
      name: "RSpec Test",
      email: "test@example.com",
      password: "password",
      confirmed_at: Time.now
    )

    user = User.new(
      name: "user name",
      email: "test@example.com",
      password: "password",
    )
    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end
  it "パスワードがない場合、無効である"
  it "パスワードが６文字以上の場合、有効である"
  it "パスワードが5文字以下の場合、無効である"
  it "パスワードと確認用パスワードの値が違う場合、無効である"
  it "画像がなくても有効である"
  it "画像のファイルサイズが5MB未満の場合、有効である"
  it "画像のファイルサイズが5MB以上の場合、無効である"
end
