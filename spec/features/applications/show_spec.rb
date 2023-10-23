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
    it "has section to search for pet to add to this application" do
      #application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
     
      visit "/applications/new"

      fill_in 'name', with: "Jimmy"
      fill_in 'street_address', with: "1234 fake st"
      fill_in 'city', with: 'littleton'
      fill_in 'state', with: 'co'
      fill_in 'zip_code', with: 85313
      fill_in 'description', with: 'cute and loveable'
      require 'pry'; binding.pry
      click_button("submit")
      expect(current_path).to eq("/applications/#{application.id}")

      expect(page).to have_field("search for a pet")
      
      fill_in 'search for a pet', with: "Mr. Pirate"
      click_button("submit")

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Mr. Pirate")
    end
    xit "can add pet to this application" do
      #application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)

      visit "/applications/new"

      fill_in 'name', with: "Jimmy"
      fill_in 'street_address', with: "1234 fake st"
      fill_in 'city', with: 'littleton'
      fill_in 'state', with: 'co'
      fill_in 'zip_code', with: 85313
      fill_in 'description', with: 'cute and loveable'

      click_button("submit")
      expect(current_path).to eq("/applications/#{application.id}")

      expect(page).to have_field("search for a pet")

      fill_in 'search for a pet', with: "Mr. Pirate"
      click_button("submit")

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Mr. Pirate")
      expect(page).to have_button("Adopt #{@pet_1.name}")

      click_button("Adopt #{@pet_1.name}")

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content(application.pet)
      expect(application.pet).to eq("Mr. Pirate")
    end
  end
end
