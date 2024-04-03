require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "Pending",
      pets: [@pet_1, @pet_2]
    )
    @application_2 = Application.create!(
      name: 'Aurora Sanderson',
      description: 'Animals are pawsome.',
      street_address: '54321 Example Street',
      city: 'Denver',
      state: 'CO',
      zip_code: 80219,
      status: "Pending",
      pets: [@pet_2, @pet_3]
    )
  end

  it "orders Z-A by name of shelter" do
    visit "/admin/shelters"
    within "#all_shelters" do
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end

  it "has a section for shelters with pending applications" do
    visit "/admin/shelters"

    within "#pending_shelters" do
      expect(page).to have_content("Aurora shelter")
      expect(page).to have_content("Fancy pets of Colorado")
      expect(page).to_not have_content("RGV animal shelter")
    end
  end
end
