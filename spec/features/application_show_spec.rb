require "rails_helper"

RSpec.describe "application show page" do

#[ ] done
# 1. Application Show Page
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application status (In progress, accepted, pending, or rejected)

  describe "when I visit the application show page" do
    it "displays the name of the applicant" do
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly")

      visit "/applications/#{applicant_1}"

      expect(page).to have_content(application_1.name)
    end
  end
end