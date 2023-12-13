require 'rails_helper'

RSpec.describe "SearchPets" do
  it "User searches for a pet by name" do

    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", 
                                     address: "97 Jaffa Road", 
                                     city: "Jerusalem", 
                                     state: "Israel", 
                                     zip_code: "9103401", 
                                     description: "Because I'm rich! :)")
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)

    #As a visitor
    #When I visit an application's show page
    visit "/applications/#{victor_app.id}"
    #And that application has not been submitted,
    #Then I see a section on the page to "Add a Pet to this Application"
    #In that section I see an input where I can search for Pets by name
    #When I fill in this field with a Pet's name
    fill_in "name", with: "Mr. Pirate"
    #And I click submit,
    click_on "Search"

    #Then I am taken back to the application show page
    #And under the search bar I see any Pet whose name matches my search
    expect(page).to have_content("Mr. Pirate")
    expect(page).not_to have_content("Clawdia")
  end
end