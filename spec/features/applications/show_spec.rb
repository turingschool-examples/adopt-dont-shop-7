require "rails_helper"

RSpec.describe "Application Show Page", type: :feature do

  describe "As a visitor" do
    describe "When I visit '/applications/:id'" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = @shelter_1.pets.create(name: "Auggie", breed: "tuxedo shorthair", age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create(name: "Rue", breed: "shorthair", age: 3, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
        @application_1 = Application.create!(name: "Julie Johnson", address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", to_adopt: "Auggie", to_adopt: "Ann", status: "In Progress")
        @application_2 = Application.create!(name: "Steve Smith", address: "705 Olive Lane", city: "Omaha", state: "NE", zip_code: "98253", description: "Emotional support animal.", to_adopt: "Rue", status: "Accepted")
        PetApplication.create!(pet:)
        
        
        @applicant_1 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id)
        @applicant_2 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_3.id)
        @applicant_3 = PetApplication.create!(application_id: @application_2.id, pet_id: @pet_2.id)
      end 

      #User Story 1
      it "displays the applicants information" do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zip_code)
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@application_1.to_adopt)
        expect(page).to have_content(@application_1.status)
        # save_and_open_page
      end 

      it "I see names of all pets the application is for" do
        within("#mypets-#{@application.id}") do
          expect(page).to have_content(@pet.name)
        end
      end
      
      it "links to the pets show page" do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_3.name)

        expect(page).to have_link(@pet_1.name)
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")

        visit "/applications/#{@application_1.id}"
        # save_and_open_page
      end
    end 
  end 
end