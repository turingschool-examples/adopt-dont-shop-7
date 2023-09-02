require "rails_helper"

RSpec.describe "applications#show" do
  before(:each) do 
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Snoopy", breed: "beagle", age: 11, adoptable: false)
    @application_1 = Application.create!(name:"Cory", street_address: "385 N Billups st.", city: "Athen", state: "GA", zipcode:"30606", description:"Extremely normal and can be trusted", status:"In Progress" )
  end

  describe "Search for pets" do 
    it "returns pet's name when searched for in the seach bar" do 
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "Mr. Pirate")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Mr. Pirate")
    end

    it "returns a message when no search results are input" do 
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("No results input to search")
    end
  end
end