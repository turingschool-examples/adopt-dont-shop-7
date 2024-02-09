require 'rails_helper'

RSpec.describe 'Application Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @shel_1 = Shelter.create!(name: "Dog's Home", city: "Gustine", foster_program: true, rank: 1)
      
      @pet_1 = @shel_1.pets.create!(name: "Cito", age: 4, breed: "Lab", adoptable: true)

      @app_1 = Application.create!(name: "Jack", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)

      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    end

    # 1. Application Show Page
    it 'displays application and all pets with attributes' do
      # When I visit an applications show page
      visit "/applications/#{@app_1.id}"
      # Then I can see the following:
      # - Name of the Applicant
      # - Full Address of the Applicant including street address, city, state, and zip code
      # - Description of why the applicant says they'd be a good home for this pet(s)
      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.street_address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip)
      expect(page).to have_content(@app_1.description)
      expect(page).to have_content(@app_1.status)
      
      # - names of all pets that this application is for (all names of pets should be links to their show page)
      expect(page).to have_link(@pet_1.name)

      # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
      expect(page).to have_content(@app_1.status)
      
    end
  end
end