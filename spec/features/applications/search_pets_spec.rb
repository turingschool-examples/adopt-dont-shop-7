require 'rails_helper'

RSpec.describe "SearchPets" do
  it "User searches for a pet by name" do

    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)

    visit "/applications/#{victor_app.id}"
    fill_in "name", with: "Mr. Pirate"
    click_on "Search"

    expect(page).to have_content("Mr. Pirate")
    expect(page).not_to have_content("Clawdia")
  end
end