require "rails_helper"

RSpec.describe "the admin applications show page", type: :feature do

  it "lists all the pets on the application" do
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    pet_1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet_2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)
    application_1 = pet_1.applications.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")
    application_2 = pet_2.applications.create!(name: "Jon Arbuckle", address: "321 Lasagna Ave, city: New Jersey, state: NJ, zip: 131313", description: "A great big ol' softy", status: "Pending")
    
    visit "/admin/applications/:id"

    expect(page).to have_button("Approve!")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end
end