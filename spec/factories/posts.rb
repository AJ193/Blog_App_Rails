FactoryBot.define do
  factory :post do
    title { 'Sample Post' }
    text { 'This is a sample post.' }
    association :author, factory: :user
  end
end
