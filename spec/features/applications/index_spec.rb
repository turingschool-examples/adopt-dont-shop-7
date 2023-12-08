require "rails_helper"

RSpec.describe "the application index" do
  before(:each) do
    @victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @victor_app.pets << [@pet_1, @pet_2]# Associates pets with the application
  end
  it "display's the applicants info" do

    visit "/applications"

    expect(page).to have_content("Victor Antonio Sanchez")
    expect(page).to have_content("97 Jaffa Road") 
    expect(page).to have_content("Jerusalem")
    expect(page).to have_content("Israel") 
    expect(page).to have_content("9103401")
    expect(page).to have_content("Because I'm rich! :)")

    expect(page).to have_content("In Progress")
  end
end