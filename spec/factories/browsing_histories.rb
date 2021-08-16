FactoryBot.define do
  factory :browsing_history do
    association :user
    association :post
  end
end
