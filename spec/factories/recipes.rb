FactoryBot.define do
  factory :recipe do
    content { 'test_content' }
    association :post
  end
end
