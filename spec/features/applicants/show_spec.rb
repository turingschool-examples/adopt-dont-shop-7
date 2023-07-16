require 'rails_helper'

RSpec.describe 'the applicant show' do
  it 'shows the applicant and all its attributes' do
    applicant = FactoryBot.build_stubbed(:applicant,
                                         name: 'Bob',
                                         street_address: '1234 a street',
                                         city: 'Irvine CA',
                                         state: 'TX',
                                         zip_code: '58200',
                                         status: 'In Progress')

    allow(Applicant).to receive(:find).with(applicant.id.to_s).and_return(applicant)

    visit "/applicants/#{applicant.id}"

    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(applicant.status)
  end
end
