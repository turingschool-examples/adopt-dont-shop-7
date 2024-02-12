require 'rails_helper'

RSpec.describe 'Admin Shelters Index Page', type: :feature do
  describe 'As a visitor' do
    before do
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
      
      @application_pets_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @application_pets_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
      @application_pets_3 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_4.id)
    end

    # User Story #10. Admin Shelters Index
    it "displays pet search results with partial matches" do
      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
      expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
    end


    # User Story # 11. Shelters with Pending Applications
    it "displays the Shelters with Pending Applications section and list" do
      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      
      # Then I see a section for "Shelters with Pending Applications"
      within(".pending_application") do
        expect(page).to have_content("Shelters with Pending Applications")
        # And in this section I see the name of every shelter that has a pending application
        expect(page).to have_content("Aurora shelter")
        expect(page).to have_content("Fancy pets of Colorado")
        expect(page).to_not have_content("RGV animal shelter")
      end
    end
  end
end