require 'rails_helper'

RSpec.describe 'Admin Application Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @shel_1 = Shelter.create!(name: "Dog's Home", city: "Gustine", foster_program: true, rank: 1)
      @shel_2 = Shelter.create!(name: "Cat's Home", city: "Gustine", foster_program: true, rank: 1)

      @pet_1 = @shel_1.pets.create!(name: "Cito", age: 4, breed: "Lab", adoptable: true)
      @pet_2 = @shel_1.pets.create!(name: "Charmander", age: 4, breed: "fire", adoptable: true)
      @pet_3 = @shel_1.pets.create!(name: "Char", age: 4, breed: "fire", adoptable: true)

      @app_1 = Application.create!(name: "Jack", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)
      @app_2 = Application.create!(name: "Jim", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 1)

      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
      PetApp.create!(application_id: @app_2.id, pet_id: @pet_3.id)
    end

    # 12. Approving a Pet for Adoption
    it "can approve individual pets on an app" do 
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{@app_2.id}"

      within "#app-status-#{@app_2.id}" do 
        # For every pet that the application is for, I see a button to approve the application for that specific pet
        expect(page).to have_button("approve")
        # When I click that button
        click_button("approve")
      end
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/applications/#{@app_2.id}")

      within "#app-status-#{@app_2.id}" do 
        # And next to the pet that I approved, I do not see a button to approve this pet
        expect(page).to_not have_content("approve")
        # And instead I see an indicator next to the pet that they have been approved
        expect(page).to have_content("Status: Accepted")
      end
    end
  end
end 
