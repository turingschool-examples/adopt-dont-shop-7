require 'rails_helper'

RSpec.describe 'the applicant show' do
  it "shows the applicant and all it's attributes" do
    applicant_1 = Applicant.create(
      name: 'Bob',
      street_address: '1234 a street',
      city: 'Irvine CA',
      state: 'TX',
      zip_code: '58200',
      status: 'In Progress'
    )

    visit "/applicants/#{applicant_1.id}"
    save_and_open_page

    expect(page).to have_content(applicant_1.name)
    expect(page).to have_content(applicant_1.street_address)
    expect(page).to have_content(applicant_1.city)
    expect(page).to have_content(applicant_1.state)
    expect(page).to have_content(applicant_1.zip_code)
    expect(page).to have_content(applicant_1.status)
  end
end
