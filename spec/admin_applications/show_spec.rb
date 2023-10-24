require "rails_helper"

RSpec.describe "As a visitor" do
  describe "When I visit the admin shelter index" do
    it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "Littleton shelter", city: "Littleton, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")

      visit "/applications/#{@application.id}"
      fill_in 'search for a pet', with: "Mr. Pirate"
      click_button("submit")
      click_button("Adopt #{@pet_1.name}")
      fill_in 'explanation', with: "cuz"
      click_button("submit application")

      visit "/admin/applications/#{@shelter_1}"


      # For every pet that the application is for, I see a button to approve the application for that specific pet
      expect(page).to have_button("Approve application for #{@pet_1.name}")
      # When I click that button
      click_button("Approve application for #{@pet_1.name}")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/applications/#{@application.id}")
      # And next to the pet that I approved, I do not see a button to approve this pet
      expect(page).to_not have_button("Approve application for #{@pet_1.name}")
      # And instead I see an indicator next to the pet that they have been approved
      expect(page).to have_content("Littleton shelter")
    end
  end
end