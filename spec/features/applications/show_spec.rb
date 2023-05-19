require 'rails_helper'

RSpec.describe Application, type: :feature do
  let!(:shelter_1) { Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)}
  
  let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frank")}

  let!(:application_1) { Application.create!(name: "John Smith", street_address: "123 Elm", city: "Denver", state: "CO", zip_code: 80205, description: "Responsible pet owner, fenced yard", status: "pending"  )}
  
  let!(:app_1) { pet_1.applications.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
  
  let!(:pet_2) { app_1.pets.create!(adoptable: true, age: 4, breed: "mutt", name: "Chaco")}
  
  let!(:application_pets_1) { ApplicationPets.create!(application: app_1, pet: pet_2) }
  
  # User Story 1
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected" 

  describe 'as a visitor, when I open the applications show page' do
    it should 'display a form' do
      # create shelters
      # create pets that belong to shelters
      # create application
      # associates application with pets


      
      visit = 
    end
  end



end