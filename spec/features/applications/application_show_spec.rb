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
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content(application_1.name)
    end
    
    it " displays full address of applicant" do
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zipcode)
    end
    
    it "description of why applicant is deserving of pet" do
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.description)
    end

    it "displays the names of all the pets on the application" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      application_1.pets << scrappy
      application_1.pets << scooby

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(scrappy.name)
      expect(page).to have_content(scooby.name)

      click_link("#{scrappy.name}")
      expect(page).to have_link("Scrappy", href: "/pets/#{scrappy.id}")
    end

    it "display the status of the application" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.status)
    end
  end

  describe "searching for pets for an application" do
    it "has a search bar to find a pet by name and see the pet returned back to me" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content("Add a Pet to this Application")

      fill_in "search", with: "Scooby"
      click_button "Search"

      expect(page).to have_content("Scooby")
      expect(page).to_not have_content("Scrappy")

      fill_in "search", with: "Scrappy"
      click_button "Search"

      expect(page).to have_content("Scrappy")

    end
  end
end