require "rails_helper"

RSpec.describe "As a visitor" do
  # 1. Application Show Page
  describe "When I visit an applications show page" do
    it "Then I can see the following" do
      application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
     
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.application_status)
    end
  end
  # 6. Submit and Application
  describe "When I visit an application's show page And I have added one or more pets to the application" do
    it "I see a section to submit my application And in that section I see an input to enter why I would make a good owner for these pet" do
      application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)

      visit "/applications/#{application.id}"
      save_and_open_page
      
      expect(find("form")).to have_content("Why would you make a good owner for these pet(s)")
    end
  end
end
