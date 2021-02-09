FactoryBot.define do
  factory :community_center do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "TEST COMMUNITY CENTER #{n}"}
    sequence(:comment) { 'HELLO' }
    sequence(:user) { |n| User.find(n) }
  end
end
