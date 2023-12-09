require 'rails_helper'

RSpec.describe ApplicationsController do
  describe "submit" do
    it "updates application status to 'Pending' and redirects to the application show page" do
      victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      #And I have added one or more pets to the application
      victor_app.pets << pet_1
      #when I visit an application's show page
      visit "/applications/#{victor_app.id}"

      #Then I see a section to submit my application
      #And in that section I see an input to enter why I would make a good owner for these pet(s)
      #When I fill in that input
      fill_in "description", with: "I am rich"

      #And I click a button to submit this application
      click_button "Submit Application"
  
      #Then I am taken back to the application's show page
      expect(page).to have_current_path("/applications/#{victor_app.id}")
      #And I see an indicator that the application is "Pending"
      expect(page).to have_content("Pending")
      #And I see all the pets that I want to adopt
      expect(page).to have_content("Mr. Pirate")
      #And I do not see a section to add more pets to this application
      expect(page).not_to have_content("Submit your application")
    end

    describe "submit" do
      it "updates application status to 'Pending' and redirects to the application show page" do
        victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)

        #when I visit an application's show page
        visit "/applications/#{victor_app.id}"
    
        #And I have not added any pets to the application
        #Then I do not see a section to submit my application

        expect(page).not_to have_content("Submit your application")
      end
    end
  end

  describe "submit" do
    it "Doesn't update to pending with no description" do
      victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      victor_app.pets << pet_1
      
      visit "/applications/#{victor_app.id}"
      fill_in "description", with: ""
      click_button "Submit Application"

      expect(page).to have_current_path("/applications/#{victor_app.id}/submit")
      expect(victor_app.reload.application_status).not_to eq('Pending')
    end
  end
end