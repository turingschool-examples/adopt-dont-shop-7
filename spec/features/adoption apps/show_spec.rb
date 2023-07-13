require "rails_helper"

RSpec.describe "The Adoption Application", type: :feature do
  #user story 1
  describe "#show page" do
    it "displays an application on the show page" do
      adoption_app = AdoptionApp.create!(name: "Suzie", street_address: "1234 Elmo Road", city: "Hoboken", state: "New Jersey", zip_code: "85790", description: "I will spoil all the pets", pet_names: "Wilmur", status: "Pending")

      visit "/adoption_apps/#{adoption_app.id}"

      expect(page).to have_content(adoption_app.name)
      expect(page).to have_content(adoption_app.street_address)
      expect(page).to have_content(adoption_app.city)
      expect(page).to have_content(adoption_app.state)
      expect(page).to have_content(adoption_app.zip_code)
      expect(page).to have_content(adoption_app.description)
      expect(page).to have_content(adoption_app.pet_names)
      expect(page).to have_content(adoption_app.status)
    end
  end
end