FactoryBot.define do
   factory :veterinary_office do
    boarding_services { Faker::Boolean.boolean }
    max_patient_capacity { Faker::Number.within(range: 5..20) }
    name { Faker::Company.name }
    association :veterinarian
  end
end
