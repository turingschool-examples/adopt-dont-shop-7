require 'rails_helper'

RSpec.describe "Admin Index Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  end

  # USER STORY 10
  it "lists all the shelter names in reverse alphabetical order" do
    visit "/admin/shelters"
    first = find("#shelter-#{@shelter_2.id}")
    second = find("#shelter-#{@shelter_3.id}")
    third = find("#shelter-#{@shelter_1.id}")
    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
  end

  # USER STORY 11
  
  it "displays all shelters in the system that have a pending application" do
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    visit "/applications/#{application.id}"
    fill_in "Search for Pets", with: "Elle"
    click_button "Submit"
    click_button "Adopt #{pet_3.name}"
    fill_in "reason", with: "I love chihuahuas and I work remotely"
    click_button "Submit this Application"
    visit '/admin/shelters'
    expect(page).to have_content("Shelters with Pending Applications")
    expect(page).to have_content(@shelter_1.name)
  end
end
