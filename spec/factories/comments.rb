FactoryBot.define do
  factory :comment do
    content { 'a' * 50 }
    association :user
    association :post
  end
end
