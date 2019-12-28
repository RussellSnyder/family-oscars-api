FactoryBot.define do
  factory :vote do
    created_by { Faker::Number.number(digits: 1) }
    nomination_id { nil }
  end
end