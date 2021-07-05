FactoryBot.define do
  factory :post do
    sequence(:name) { |n| "post_name#{n}" }
    content { '説明文' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/post_default_image.jpeg'), 'image/jpeg') }
    protein { 100.1 }
    fat { 100.1 }
    carbo { 100.1 }
    calorie { 100 }
    serve { 2 }
    association :user
  end
end
