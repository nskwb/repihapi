FactoryBot.define do
  factory :post do
    sequence(:name) { |n| "post_name#{n}" }
    content { '説明文' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/default_post_image.jpeg'), 'image/jpeg') }
    protein { 100.1 }
    fat { 100.1 }
    carbo { 100.1 }
    calorie { 100 }
    serve { 2 }
    association :user
  end

  factory :post_with_children, class: Post do
    sequence(:name) { |n| "post_name#{n}" }
    content { '説明文' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/default_post__image.jpeg'), 'image/jpeg') }
    protein { 100.1 }
    fat { 100.1 }
    carbo { 100.1 }
    calorie { 100 }
    serve { 2 }
    association :user

    after(:create) do |post|
      create(:ingredient, post: post)
      create(:recipe, post: post)
    end
  end
end
