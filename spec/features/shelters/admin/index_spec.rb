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

  it "lists the shelters in reverse alphabetical order" do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it "has a link to sort shelters by the number of pets they have" do
    visit "/admin/shelters"
    

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path("/shelters?sort=pet_count")
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_2.name)
  end

  it "has a link to update each shelter" do
    visit "/admin/shelters"
    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Update #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Update #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Update #{@shelter_3.name}")
    end

    click_on("Update #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
  end

  it "has a link to delete each shelter" do
    visit "/admin/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Delete #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Delete #{@shelter_3.name}")
    end

    click_on("Delete #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it "has a text box to filter results by keyword" do
    visit "/admin/shelters"
    expect(page).to have_button("Search")
  end

  it "lists partial matches as search results" do
    visit "/admin/shelters"

    fill_in "Search", with: "RGV"
    click_on("Search")

    expect(page).to have_content(@shelter_2.name)
    expect(page).to_not have_content(@shelter_1.name)
  end

  it "shows the name of every shelter that has a pending application" do 
    applicant_1 = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    applicant_2 = Application.create(name: "daphe", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    new_pet = applicant_1.pets.create(name: "Bonkus", breed: "Definitely", age: 1, adoptable: true, shelter_id: @shelter_1.id)
    applicant_1.change_application_status("Pending")

    visit "/admin/shelters"

    expect(page).to have_content("Has Applications: #{@shelter_1.name}")
    expect(page).to_not have_content("Has Applications: #{@shelter_2.name}")
  end
end
