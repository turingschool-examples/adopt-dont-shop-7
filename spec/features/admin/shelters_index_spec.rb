require "rails_helper"

RSpec.describe "the admin shelter index", type: :feature do

  it "lists all shelters in reverse alphabetical order" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    visit "/admin/shelters"
    
    expect(page.body.index("RGV animal shelter")).to be < page.body.index("Aurora shelter")
    expect(page.body.index("RGV animal shelter")).to_not be > page.body.index("Aurora shelter")
  end
  
  it "shows a section for Shelters with Pending Applications" do
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    pet1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    application1 = pet1.applications.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")
    
    visit "/admin/shelters"
    expect(page).to have_content("Shelters with Pending Applications")
  end

  it "shows the section with the shelters with pending applications populated" do
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    pet1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    application1 = pet1.applications.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")
    
    visit "/admin/shelters"
    
    within("#pending-applications") do
    expect(page).to have_content("Aurora shelter")
    expect(page).to_not have_content("RGV animal shelter")
    end
  end
end
