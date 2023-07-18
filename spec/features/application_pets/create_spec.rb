require 'rails_helper'

RSpec.describe "application pets creation" do
  before(:each) do
    @mr_ape = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "CO", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
  end
  
  describe "create application pets" do
    it "throws an error if application_pet does not save" do
      visit "/applications/#{@mr_ape.id}"

      fill_in "Pet Search", with: "Mr. Pirate"
      click_button "Search"

      click_on "Adopt this Pet"
      
      fill_in "Pet Search", with: "Mr. Pirate"
      click_button "Search"

      click_on "Adopt this Pet"

      expect(page).to have_content("Error: Application already has that pet.")
    end
  end
end