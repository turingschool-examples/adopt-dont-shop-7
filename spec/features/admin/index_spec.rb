require 'rails_helper'

RSpec.describe 'the admin/shelters' do
  before(:each) do
    @shelter1 = Shelter.create(
      name: 'Aurora Shelter',
      city: 'Aurora, CO',
      foster_program: false,
      rank: 9
    )

    @shelter2 = Shelter.create(
      name: 'Beggin Strips Shelter',
      city: 'Howell, NJ',
      foster_program: true,
      rank: 10
    )

    @shelter3 = Shelter.create(
      name: 'Cookies for Days Shelter',
      city: 'Los Angeles, CA',
      foster_program: false,
      rank: 11
    )
  end

  # User Story 10 Test
  it 'lists all the shelters with their attributes in reverse alphabetical order' do
    visit '/admin/shelters'

    expect(page).to have_content(@shelter3.name)
    expect(page).to have_content(@shelter2.name)
    expect(page).to have_content(@shelter1.name)

    expect(@shelter3.name).to appear_before(@shelter2.name)
    expect(@shelter2.name).to appear_before(@shelter1.name)
  end

  # User Story 11 Test
  xit 'lists all the shelters with pending applications' do
    
    ApplicantsPet.create(applicant: applicant1, pet: pet1)
    applicant1.reload

    visit "/pets/#{pet1.id}"
    expect(page).to have_content("Shelter Name: #{shelter1.name}")

    visit "/applicants/#{applicant1.id}"
    expect(page).to have_content('Status: Pending')

    visit '/admin/shelters'
    within('#pending-applications-title + p', text: shelter1.name) do
      expect(page).to have_content(shelter1.name)
    end
  end
end
