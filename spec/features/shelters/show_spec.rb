require "rails_helper"

RSpec.describe "the shelter show" do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.rank)
    expect(page).to have_content(shelter.city)
  end

  it "shows the number of pets associated with the shelter" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter.pets.create(name: "garfield", breed: "shorthair", adoptable: true, age: 1)

    visit "/shelters/#{shelter.id}"

    within ".pet-count" do
      expect(page).to have_content(shelter.pets.count)
    end
  end

  it "allows the user to delete a shelter" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    click_on("Delete #{shelter.name}")

    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(shelter.name)
  end

  it "displays a link to the shelters pets index" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: true, rank: 9)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_link("All pets at #{shelter.name}")
    click_link("All pets at #{shelter.name}")

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
  end

  it "Will only show shelter name and address when visited by admin" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)


    visit "/admin/shelter/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
    expect(page).to_not have_content(shelter_1.forster_program)
    expect(page).to_not have_content(shelter_1.rank)
  end
end
