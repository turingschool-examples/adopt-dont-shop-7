require 'rails_helper'

RSpec.describe "Pet Adoption" do
  it "User adopts a pet through an application" do
    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
   
    #When I visit an application's show page
    visit "/applications/#{victor_app.id}"
    #And I search for a Pet by name
    fill_in "name", with: "Mr. Pirate"
    click_on "Search"
    #And I see the names Pets that match my search
    expect(page).to have_content("Mr. Pirate")
    #When I click one of these buttons
    click_on "Adopt this Pet" 
    #Then I am taken back to the application show page
    expect(page).to have_current_path("/applications/#{victor_app.id}")
    #And I see the Pet I want to adopt listed on this application
    expect(page).to have_content("Mr. Pirate")
  end
end