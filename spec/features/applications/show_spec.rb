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
      adoption_app = AdoptionApp.create!()
      visit "/adoption_apps"

      expect(page).to have_content("Applicant Name")
      expect(page).to have_content("Street Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip Code")
      expect(page).to have_content("Explain Yourself")
      expect(page).to have_content("Pet Names")
      expect(page).to have_content("Status")
    end
  end
end