FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 1) }
  end
end