FactoryBot.define do
  factory :comment do
<<<<<<< HEAD
    body { 'This is a comment.' }
=======
    text { 'This is a comment.' }
>>>>>>> 67a78bbfcbc12753475b18de3f640ed9a9164892
    association :author, factory: :user
    association :post, factory: :post
  end
end
