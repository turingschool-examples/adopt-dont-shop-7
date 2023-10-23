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
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)

      visit "/applications/new"

      fill_in 'name', with: "Jimmy"
      fill_in 'street_address', with: "1234 fake st"
      fill_in 'city', with: 'littleton'
      fill_in 'state', with: 'co'
      fill_in 'zip_code', with: 85313
      fill_in 'description', with: 'cute and loveable'

      click_button("Submit Application")
      expect(current_path).to eq("/applications/#{@application.id + 1}")

      expect(page).to have_field("search for a pet")
      
      fill_in 'search for a pet', with: "Mr. Pirate"
      click_button("submit")

      expect(current_path).to eq("/applications/#{@application.id + 1}")
      expect(page).to have_content("Mr. Pirate")
    end

    it "can add pet to this application" do
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)

      visit "/applications/#{@application.id}"

      expect(page).to have_field("search for a pet")
      
      fill_in 'search for a pet', with: "Mr. Pirate"
      click_button("submit")

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_button("Adopt #{@pet_1.name}")
      click_button("Adopt #{@pet_1.name}")
      
      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_link(@pet_1.name)
      expect(@application.pets).to include(@pet_1)
    end
    it "can find partial matches for pets in the search bar" do
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "fluffy", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: "fluff", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: "mr. fluff", breed: "tuxedo shorthair", age: 5, adoptable: true)

      visit "/applications/#{@application.id}"

      expect(page).to have_field("search for a pet")
      
      fill_in 'search for a pet', with: "fluff"
      click_button("submit")

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("fluffy")
      expect(page).to have_content("fluff")
      expect(page).to have_content("mr. fluff")
    end
    it "can find partial matches for pets in the search bar" do
      @application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Fluffy", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: "FLUFF", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: "Mr. FlufF", breed: "tuxedo shorthair", age: 5, adoptable: true)

      visit "/applications/#{@application.id}"

      expect(page).to have_field("search for a pet")
      
      fill_in 'search for a pet', with: "fluff"
      click_button("submit")

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Fluffy")
      expect(page).to have_content("FLUFF")
      expect(page).to have_content("Mr. FlufF")
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
      
      expect(find("form")).to have_content("why would you make a good owner for these pet(s)")
    end
  end
end
