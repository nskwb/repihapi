FactoryBot.define do
  factory :meal_record do
    start_time { Time.zone.now }
    association :user
    association :post
  end
end
