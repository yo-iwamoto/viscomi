FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "TEST USER#{n}" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    sequence(:password) { 'foobarbaz' }
  end
end
