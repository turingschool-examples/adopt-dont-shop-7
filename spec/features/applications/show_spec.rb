require "rails_helper"

RSpec.describe "applications show page", type: :feature do
  it "shows the application" do
    shelter1 = Shelter.create!(name: "Camp Fuzzy", rank: "7", city: "Manhattan")
    application1 = shelter1.applications.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Accepted")
    pet1 = shelter1.pets.create!(name: "Fido", age: 1)
  end
end
