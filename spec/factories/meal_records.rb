FactoryBot.define do
  factory :meal_record do
    start_time {}
    post_name {}
    post_protein {}
    post_fat {}
    post_carbo {}
    post_calorie {}
    association :user
    association :post
  end
end
