require "rails_helper"

RSpec.describe "Application New Page" do 
  before(:each) do 
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @application1 = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I lika da pets", status: "In Progress")
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
  end

# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
#   - Description of why I would make a good home
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
  describe "visiting the application new page" do 
    it "has a form to fill in with required fields to create an application" do
      visit "applications/new"

      expect(page).to have_field(:name)
      expect(page).to have_field(:street_address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip_code)
      expect(page).to have_field(:description)
      expect(page).to have_button("Submit")
    end

  end

end