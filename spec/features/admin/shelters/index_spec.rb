require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  end

  it "lists all the shelter names" do
    visit "/admin/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it "lists all the shelter names in reverse alphabetical order" do
    visit "/admin/shelters"

    end_of = find("#shelter-#{@shelter_2.id}")
    mid_of = find("#shelter-#{@shelter_3.id}")
    start_of = find("#shelter-#{@shelter_1.id}")

    expect(end_of).to appear_before(mid_of)
    expect(mid_of).to appear_before(start_of)
  end

  it "shows the shelters with pending applications" do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: true, rank: 9)
    application_1 = Application.create(name: "John Dwayne", address: "1010 W 50th Ave, Denver, CO, 80020", description: "Background as a dog sitter", status: "Pending")
    pet = application_1.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")
    expect(page).to have_content(shelter.name)
  end
end