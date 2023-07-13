require "rails_helper"

RSpec.describe "The Adoption Application", type: :feature do
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
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