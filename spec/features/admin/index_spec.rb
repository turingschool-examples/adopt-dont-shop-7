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
    @bob = Applicant.create!(name: "Bob", 
      street_address: "1234 Bob's Street", 
      city: "Fudgeville", 
      state: "AK", 
      zip_code: 27772, 
      description: ""
      )

    @pet_1 = Pet.create(adoptable: true, 
      age: 1, breed: "sphynx", 
      name: "Lucille Bald", 
      shelter_id: @shelter1.id)

    @pet_2 = Pet.create(adoptable: true, 
      age: 3, breed: "doberman", 
      name: "Lobster", 
      shelter_id: @shelter1.id)

      ApplicantsPet.create(applicant: @bob, pet: @pet_1)
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
  it 'lists all the shelters with pending applications' do

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("#{@shelter1.name}")

    visit "/applicants/#{@bob.id}"
    fill_in "description", with: "i want a dog"
          click_button "Submit Application"
          expect(page).to have_content('Pending')
    save_and_open_page

    visit '/admin/shelters'
    within('#pending') do
    save_and_open_page
      expect(page).to have_content(@shelter1.name)
    end
  end
end
