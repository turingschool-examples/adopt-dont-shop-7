require 'rails_helper'

RSpec.describe 'Adoption Application Show page', type: :feature do

   # User Story 1
   it 'has the applicant name, address, good fit and status' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      # application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")


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
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add Pets to this Application")
      expect(page).to have_content("Search Pet by Name")
   end

   it 'has a section to add a Pet to the application' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)

      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")


      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")


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

      expect(page).to have_button("#{pet_1.name}")
   end

   
   # User Story 8
   it 'is has partial matches' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

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

      expect(page).to have_button("#{pet_1.name}")
   end

   it 'is has partial matches' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "SCOOBY", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "ScRaPpY", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

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

      expect(page).to have_button("Adopt #{pet_1.name}")
   end

   it 'display a button to adopt the pet under each pet' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"

      fill_in "search", with: "scooby"
      click_button "Search"

      expect(page).to have_button("Adopt Scooby")
   end

   it 'shows added pets to adoption application' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"

      fill_in "search", with: "scooby"
      click_button "Search"

      click_button "Adopt Scooby"
      
      fill_in "search", with: "a"

      expect(page).to have_content(pet_1.name)
   end

   it "shows a session to why the user would be a good owner after they add the pet to the application" do 
      
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"

      
      expect(page).to have_content("Why would you be a good owner to the pet(s)")
   end

   it "DOES NOT shows a session to why the user would be a good owner BEFORE they add the pet to the application" do 
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"
      
      expect(page).to_not have_content("Why would you be a good owner to the pet(s)")
   end

   it "shows submit application button if I added pets to the application" do 
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"
      
      expect(page).to have_button("Submit Application")
   end

   it "DOES NOT shows submit application button if I DID NOT added pets to the application" do 
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"
      
      expect(page).to have_button("Submit Application")
   end

   it "changes the adoption application status after I submit application" do 
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      visit "/applications/#{application.id}"
      
      expect(page).to have_content("In Progress")

      fill_in "ownership_description", with: "Because I love them"

      click_button "Submit Application"

      expect(page).to have_content("Pending")
   end
end