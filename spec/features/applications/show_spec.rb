require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @victor_app.pets << [@pet_1, @pet_2]# Associates pets with the application
  end
  it "display's the applicants info" do
    # 1. Application Show Page
    # As a visitor
    # When I visit an applications show page
    visit "/applications/#{@victor_app.id}"
    # Then I can see the following:
    # - Name of the Applicant
    expect(page).to have_content("Applicant Name: Victor Antonio Sanchez")
    # - Full Address of the Applicant including street address, city, state, and zip code
    expect(page).to have_content("Address: 97 Jaffa Road Jerusalem, Israel 9103401")
    # - Description of why the applicant says they'd be a good home for this pet(s)
    expect(page).to have_content("Description: Because I'm rich! :)")
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    expect(page).to have_link("Mr. Pirate")
    expect(page).to have_link("Clawdia")
    expect(page).to_not have_link("Ann")
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    expect(page).to have_content("Application Status: In Progress")
    save_and_open_page
  end
end