require 'rails_helper'

RSpec.describe 'Admin Applications Show Page', type: :feature do
 describe 'As a visitor' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_3.id)
    @pet_3 = Pet.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Rocky", shelter_id: @shelter_1.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: "corgi", name: "fluffy", shelter_id: @shelter_2.id)
    @pet_5 = Pet.create!(adoptable: true, age: 8, breed: "bernese mountain", name: "Mr. fluff", shelter_id: @shelter_3.id)
    @pet_6 = Pet.create!(adoptable: true, age: 7, breed: "persian", name: "FLUFF", shelter_id: @shelter_1.id)
    
    @application_1 = Application.create!(name: "Selena", street_address: "123 Street", city: "City", state: "State", zip_code: "8888", adopting_reason: "Love for cats, no job", status:"Pending")
    @application_2 = Application.create!(name: "Laura", street_address: "58 Street", city: "City", state: "State", zip_code: "5555", adopting_reason: "Need company", status:"Rejected")
    @application_3 = Application.create!(name: "Isaac", street_address: "456 Street", city: "City", state: "State", zip_code: "8878", adopting_reason: "Lots of love to give", status:"Accepted")
    @application_4 = Application.create!(name: "Mark", street_address: "889 Folsom Ave", city: "Denver", state: "CO", zip_code: "80024", adopting_reason: "Lonely", status:"Pending")
    
    @application_pets_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_4.id)
    @application_pets_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_4.id)
    @application_pets_3 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_3.id)
  end

  #User Story 12. Approving a Pet for Adoption
  it 'allows to approve a pet for adoption' do
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/applications/#{@application_4.id}"

    # For every pet that the application is for, I see a button to approve the application for that specific pet
    within '.pets' do
      within "#pet-#{@pet_2.id}" do
        # When I click that button
        click_button("Approve Application")
      end
    end
    # Then I'm taken back to the admin application show page
    expect(current_path).to eq("/admin/applications/#{@application_4.id}")

    within"#pet-#{@pet_2.id}" do
      # And next to the pet that I approved, I do not see a button to approve this pet
      expect(page).to_not have_button("Approve Application for #{@pet_2.name}")
      
      # And instead I see an indicator next to the pet that they have been approved
      expect(page).to have_content("Application approved for #{@pet_2.name}")
    end
  end

  #User Story 13. Rejecting a Pet for Adoption
  it "allows to reject a pet for adoption" do
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/applications/#{@application_4.id}"
    # For every pet that the application is for, I see a button to reject the application for that specific pet
    within '.pets' do
      within "#pet-#{@pet_1.id}" do
      # When I click that button
      click_button("Reject Application")
    end
  end
  # Then I'm taken back to the admin application show page
  expect(current_path).to eq("/admin/applications/#{@application_4.id}")
  save_and_open_page

    within"#pet-#{@pet_1.id}" do
      # And next to the pet that I rejected, I do not see a button to approve or reject this pet
      expect(page).to_not have_button("Approve Application for #{@pet_1.name}")
      expect(page).to_not have_button("Reject Application for #{@pet_1.name}")
      
      # And instead I see an indicator next to the pet that they have been rejected
      expect(page).to have_content("Application rejected for #{@pet_1.name}")
    end
  end
 end
end