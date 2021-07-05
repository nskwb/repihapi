FactoryBot.define do
  factory :ingredient do
    name { 'test_ingredient' }
    amount { '100g' }
    association :post
  end
end
