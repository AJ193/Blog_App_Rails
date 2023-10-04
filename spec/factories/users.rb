FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    photo { 'assets/images/default.jpg' }
    bio { 'Mr: Kamran' }
  end
end
