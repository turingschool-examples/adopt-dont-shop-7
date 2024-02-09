require 'rails_helper'

RSpec.describe 'Adoption Application Show page', type: :feature do
   
   # Name of the Applicant
   # Full Address of the Applicant including street address, city, state, and zip code
   # Description of why the applicant says they'd be a good home for this pet(s)
   # names of all pets that this application is for (all names of pets should be links to their show page)
   # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
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

end