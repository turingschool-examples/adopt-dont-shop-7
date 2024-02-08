require 'rails_helper'

RSpec.describe "Application Show Page" do
  let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "Pending")}
  let!(:application_2) {Application.create!(name: "Marcus", street_address: "100 Hennepin Ave.", city: "Minneapolis", state: "MN", zip_code: "55401", description: "Dogs are the best. Please let me have one.", status: "In Progress")}

  let!(:shelter_1) {foster_program: true, name: "Adopters Unite", city: "Minneapolis", rank: 1}
  let!(:pet_1) {shelter_1.pets.create!(adoptable: true, age: 2, breed: "doberman", name: "Rover")}
  let!(:pet_2) {shelter_1.pets.create!(adoptable: true, age: 1, breed: "dalmatian", name: "Pongo")}

  let!(:application_pet_1) {ApplicationPet.create!(pet: pet_1, application: application_1)}
  let!(:application_pet_2) {ApplicationPet.create!(pet: pet_2, application: application_2)}

  describe "As a Visitor" do
    describe "User Story 1 - display application info" do
      before do
        visit "/applications/#{application_1.id}"
      end
      
      it "applicant's name" do
        expect(page).to have_content(application_1.name)
        expect(page).to_not have_content(application_2.name)
      end
        
      describe "applicant's address" do
        it "application's street address" do
          expect(page).to have_content(application_1.street_address)
          expect(page).to_not have_content(application_2.street_address)
        end
        
        it "application's city" do
          expect(page).to have_content(application_1.city)
          expect(page).to_not have_content(application_2.city)
        end
        
        it "application's state" do
          expect(page).to have_content(application_1.state)
          expect(page).to_not have_content(application_2.state)
        end
        
        it "application's zip" do
          expect(page).to have_content(application_1.zip)
          expect(page).to_not have_content(application_2.zip)
        end
      end
      
      it "application's description" do
        expect(page).to have_content(application_1.description)
        expect(page).to_not have_content(application_2.description)
      end

      describe "pets applied for" do
        it "lists pets names" do
          expect(page).to have_content(pet_1.name)
          expect(page).to_not have_content(pet_2.name)
        end

        it "links pet names' to pet's show page" do
          expect(page).to have_link("Rover")

          click_link "Rover"
          expect(current_path).to eq("/pets/#{pet_1.id}")
        end
      end
      
      it "applicantion's status" do
        expect(page).to have_content(application_1.status)
        expect(page).to_not have_content(application_2.status)
      end
    end
  end
end