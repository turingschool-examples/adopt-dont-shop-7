require "rails_helper"

RSpec.describe "Applications", type: :feature do
  describe "application#show" do
    # 1. Application Show Page

    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    it "shows a specific application" do
      shelter = Shelter.create!(foster_program: true, name: "Bishop Animal Rescue", city: "Bishop", rank: 5)
      pet = shelter.pets.create!(adoptable: true, age: 6, breed: "Samoyed", name: "Fluffy")
      app = pet.applications.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled")

      visit "/applications/#{app.id}"

      expect(page).to have_content("Name: Garrett")
      expect(page).to have_content("Street Address: 123 Upland")
      expect(page).to have_content("City: Bishop")
      expect(page).to have_content("State: CA")
      expect(page).to have_content("Zip Code: 12345")
      expect(page).to have_content("Description: I'm the best -DJ Khaled")

      expect(page).to have_link("Fluffy")
      # ^ later need to test that this link goes to fluffy's show page
      expect(page).to have_content("In Progress")
    end
  end
end