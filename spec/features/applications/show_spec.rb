require "rails_helper"

RSpec.describe "applications show page", type: :feature do
  it "shows an application" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)

    application1 = pet1.applications.create!(
      name: "Fred Flintstone",
      address: "123 Main St, city: New York, state: NY, zip: 70117",
      description: "Worked with dinosaurs",
      status: "Accepted"
    )

    visit "/applications/#{application1.id}"
  end
end
