FactoryBot.define do
  factory :applicant do
    name { 'Bob' }
    street_address { '1234 a street' }
    city { 'Irvine CA' }
    state { 'TX' }
    zip_code { '58200' }
    status { 'In Progress' }
  end
end
