require "rails_helper"

RSpec.describe "As a visitor", type: :feature do
  describe "When I visit the admin applications show page" do
    it "Then I see button to approve pet for application" do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "Littleton shelter", city: "Littleton, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @petapp = PetApplication.create(application: @application, pet: @pet_1)
      # require'pry';binding.pry
      visit "/admin/applications/#{@application.id}"
  
      # For every pet that the application is for, I see a button to approve the application for that specific pet
      expect(page).to have_button("Approve application for #{@pet_1.name}")
      # When I click that button
      click_button("Approve application for #{@pet_1.name}")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      # And next to the pet that I approved, I do not see a button to approve this pet
      expect(page).to_not have_button("Approve application for #{@pet_1.name}")
      # And instead I see an indicator next to the pet that they have been approved
      expect(page).to have_content("Approved")
    end
  end
  describe "When I visit the admin applications show page" do
    xit "Then I see button to reject pet for application" do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "Littleton shelter", city: "Littleton, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      PetApplication.create(application: @application, pet: @pet_1)
      
      visit "/admin/applications/#{@application.id}"

      # For every pet that the application is for, I see a button to reject the application for that specific pet
      expect(page).to have_button("Reject application for #{@pet_1.name}")
      # When I click that button
      click_button("Reject application for #{@pet_1.name}")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      # And next to the pet that I rejected, I do not see a button to reject this pet
      expect(page).to_not have_button("Reject application for #{@pet_1.name}")
      # And instead I see an indicator next to the pet that they have been approved
      expect(page).to have_content("Rejected")
    end
  end
end