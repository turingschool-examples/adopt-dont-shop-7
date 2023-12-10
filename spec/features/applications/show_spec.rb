require 'rails_helper'

RSpec.describe 'The Application Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      # Shelters
      @puppy_hope = Shelter.create!(name: 'Puppy Hope', city: 'Palo Alto',foster_program: true, rank: 1 )
      # Pets
      @pet_1 = Pet.create!(name: 'Sparky', age: 4, breed: 'Chihuahua', adoptable: true, shelter_id: @puppy_hope.id )
      # Applications 
      @app_1 = Application.create!(name: 'Megan Samuels', street_address: '505 E. Happy Pl', city: "Austin", state: "MN", zip: "55912", description: 'I love dogs', status: 0)
      # Pet Applications 
      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    end

    # 1. Application Show Page
    it "displays the applicant information" do
      # When I visit an applications show page
      visit "/applications/#{@app_1.id}"
      # Then I can see the following:
      # - Name of the Applicant
      expect(page).to have_content(@app_1.name)
      # - Full Address of the Applicant including street address, city, state, and zip code
      expect(page).to have_content(@app_1.street_address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip)
      # - Description of why the applicant says they'd be a good home for this pet(s)
      expect(page).to have_content(@app_1.description)
      # - names of all pets that this application is for (all names of pets should be links to their show page)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_link(@pet_1.name)
      # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
      expect(page).to have_content("In Progress")
      within '.pets-on-apps' do
        click_on(@pet_1.name)
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end
    end
  end
end