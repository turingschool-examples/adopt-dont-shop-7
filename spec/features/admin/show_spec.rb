require 'rails_helper'

RSpec.describe 'the /admin/applications/:id' do
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
      ApplicantsPet.create(applicant: @bob, pet: @pet_2)
  end

  # User Story 12 Test
  it 'For every pet that the application is for, I see a button to approve the application ' do
    visit "/admin/applications/#{@bob.id}"


    
    within("##{@pet_1.id}") do
    expect(page).to have_button("Approve Application")
    expect(page).to have_content("Pending")
    click_button "Approve Application"
    end

    expect(current_path).to eq("/admin/applications/#{@bob.id}")

    within("##{@pet_1.id}") do
    expect(page).to have_content("Approved")
    expect(page).to_not have_button("Approve Application")
    end

    within("##{@pet_2.id}") do
    expect(page).to have_button("Approve Application")
    expect(page).to have_content("Pending")
    end
  end

  # User Story 13 Test
  it 'For every pet that the application is for, I see a button to reject the application ' do
    visit "/admin/applications/#{@bob.id}"


    
    within("##{@pet_1.id}") do
    expect(page).to have_button("Reject Application")
    expect(page).to have_content("Pending")
    click_button "Reject Application"
    end

    expect(current_path).to eq("/admin/applications/#{@bob.id}")

    within("##{@pet_1.id}") do
    expect(page).to have_content("Rejected")
    expect(page).to_not have_button("Reject Application")
    end

    within("##{@pet_2.id}") do
    expect(page).to have_button("Approve Application")
    expect(page).to have_content("Pending")
    end
  end
end
