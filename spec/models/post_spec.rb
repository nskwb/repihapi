require 'rails_helper'

RSpec.describe Post, type: :model do
  it '名前・説明文・タンパク質・脂肪・炭水化物・カロリー・人数・ユーザーidがある場合、有効である' do
  end
  it '名前がない場合、無効である'
  it '名前が50文字以下の場合、有効である'
  it '名前が51文字以上の場合、無効である'
  it '重複した名前がある場合、無効である'
  it '説明文がない場合、無効である'
  it '説明文が200文字以下の場合、有効である'
  it '説明文が201文字以上の場合、無効である'
  it 'タンパク質がない場合、無効である'
  it 'タンパク質が0以上の場合、有効である'
  it 'タンパク質が0未満の場合、無効である'
  it '脂肪がない場合、無効である'
  it '脂肪が0以上の場合、有効である'
  it '脂肪が0未満の場合、無効である'
  it '炭水化物がない場合、無効である'
  it '炭水化物が0以上の場合、有効である'
  it '炭水化物が0未満の場合、無効である'
  it 'カロリーがない場合、無効である'
  it 'カロリーが0以上の場合、有効である'
  it 'カロリーが0未満の場合、無効である'
  it '人数がない場合、無効である'
  it '人数が0以上の場合、有効である'
  it '人数が0未満の場合、無効である'
  it 'ユーザーidがない場合、無効である'
  it '画像がない場合無効である'
  it '画像のファイルサイズが5MB未満の場合、有効である'
  it '画像のファイルサイズが5MB以上の場合、無効である'
end
