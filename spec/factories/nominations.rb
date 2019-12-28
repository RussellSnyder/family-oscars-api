FactoryBot.define do
  factory :nomination do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 1) }
    category_id { nil }
  end
end