require 'rails_helper'

RSpec.describe "Admin Shelters Index Page" do
  let!(:shelter_1) {Shelter.create!(foster_program: true, name: "Adopters Unite", city: "Minneapolis", rank: 1 ) }
  let!(:shelter_2) {Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) }
  let!(:shelter_3) {Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)}

  let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "pending")}
  let!(:application_2) {Application.create!(name: "Marcus", street_address: "100 Hennepin Ave.", city: "Minneapolis", state: "MN", zip_code: "55401", description: "Dogs are the best. Please let me have one.", status: "pending")}

  let!(:pet_1) {shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Rover")}
  let!(:pet_2) {shelter_2.pets.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Pongo")}
  let!(:pet_3) {shelter_3.pets.create!(adoptable: true, age: 1, breed: "dalmatian", name: "Pongo II")}

  let!(:application_pet_1) {ApplicationPet.create!(pet: pet_1, application: application_1)}
  let!(:application_pet_2) {ApplicationPet.create!(pet: pet_2, application: application_2)}

  before do
    visit "/admin/shelters"
  end

  describe "As a Visitor" do
    describe "User Story 10" do
      it "lists all shelters names in reverse alphabetical order" do
        save_and_open_page
        expect(shelter_3.name).to appear_before(shelter_2.name)
        expect(shelter_2.name).to appear_before(shelter_1.name)
      end
    end

    describe "User Story 11" do
      it "has a section for pending applications" do
        within("#pending_apps") do
          expect(page).to have_content(shelter_1.name)
          expect(page).to have_content(shelter_2.name)
          expect(page).to_not have_content(shelter_3.name)
        end
      end
    end
  end
end
