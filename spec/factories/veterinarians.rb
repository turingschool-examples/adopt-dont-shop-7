FactoryBot.define do
  factory :veterinarian do
    on_call { Faker::Boolean.boolean }
    review_rating { Faker::Number.within(range: 1..5) }
    name { Faker::Name.name}
  end
end
