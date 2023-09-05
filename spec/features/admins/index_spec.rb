require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @application = Application.create!(name: "John Smith", street_address: "123 Main st", city: "Boulder", state: "CO", zip_code: "12345", description: "I'm rich.", status: "Pending")
    PetApplication.create!(pet: @pet, application: @application)
  end

  # US 10
  it "can see all shelters listed in reverse alphabetical order" do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  # US 11
  it "can see the name of all shelters with pending applications" do
    visit "/admin/shelters"

    within("#pending_applications") do
      expect(page).to have_content(@shelter_1.name)
    end
  end
end