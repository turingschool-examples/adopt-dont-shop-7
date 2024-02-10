require 'rails_helper'

RSpec.describe 'Adoption Application Show page', type: :feature do

   # User Story 1
   it 'has the applicant name, address, good fit and status' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      # application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(application.status)
   end

   # User Story 4
   it 'has a section to add a Pet to the application' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add Pets to this Application")
      expect(page).to have_content("Search Pet by Name")
   end

     
      # And I search for a Pet by name
      # And I see the names Pets that match my search
      # Then next to each Pet's name I see a button to "Adopt this Pet"
      # When I click one of these buttons
      # Then I am taken back to the application show page
      # And I see the Pet I want to adopt listed on this application
   it 'has a section to add a Pet to the application' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add Pets to this Application")
      expect(page).to have_content("Search Pet by Name")

      fill_in "search", with: "Sc"
      click_on "Search"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.breed)
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content(pet_1.adoptable)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.breed)
      expect(page).to have_content(pet_2.age)
      expect(page).to have_content(pet_2.adoptable)

      expect(page).to have_button("Adopt this Pet")
   end
   
   it 'is case insensitive and has partial matches' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add Pets to this Application")
      expect(page).to have_content("Search Pet by Name")

      fill_in "search", with: "sc"
      click_on "Search"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.breed)
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content(pet_1.adoptable)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.breed)
      expect(page).to have_content(pet_2.age)
      expect(page).to have_content(pet_2.adoptable)

      expect(page).to have_button("Adopt this Pet")
   end
end