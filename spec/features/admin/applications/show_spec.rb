require 'rails_helper'

RSpec.describe "Admin Application Show Page" do
  let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "pending")}
  let!(:application_2) {Application.create!(name: "Marcus", street_address: "100 Hennepin Ave.", city: "Minneapolis", state: "MN", zip_code: "55401", description: "Dogs are the best. Please let me have one.", status: "pending")}

  let!(:shelter_1) {Shelter.create!(foster_program: true, name: "Adopters Unite", city: "Minneapolis", rank: 1 ) }

  let!(:pet_1) {shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Rover")}
  let!(:pet_2) {shelter_1.pets.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Pongo")}

  let!(:application_pet_1) {ApplicationPet.create!(pet: pet_1, application: application_1)}
  let!(:application_pet_2) {ApplicationPet.create!(pet: pet_2, application: application_1)}
  let!(:application_pet_3) {ApplicationPet.create!(pet: pet_1, application: application_2)}
  let!(:application_pet_4) {ApplicationPet.create!(pet: pet_2, application: application_2)}
  describe "As a visitor" do
    describe "User Story 12" do
      describe "When I visit an admin application show page" do
        it "sees a button to approve each pet in the application, after I click on the button, I'm taken back to the admin application show page and see 'Approved' next to that pet" do
          visit "/admin/applications/#{application_1.id}"
          # binding.pry
          expect(page).to have_button("Approve", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)

          click_on "Approve", match: :first
          click_on "Approve"

          expect(current_path).to eq("/admin/applications/#{application_1.id}")
          expect(page).not_to have_button("Approve")
          expect(page).to have_content("Approved", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)
        end
      end
    end

    describe "User Story 13" do
      describe "When I visit an admin application show page" do
        it "sees a button to reject each pet in the application, after I click on the button, I'm taken back to the admin application show page and see 'Rejected' next to that pet" do
          visit "/admin/applications/#{application_1.id}"
          expect(page).to have_button("Reject", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)
          click_on "Reject", match: :first
          click_on "Reject"

          expect(current_path).to eq("/admin/applications/#{application_1.id}")
          expect(page).not_to have_button("Reject")
          expect(page).to have_content("Rejected", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)
        end
      end
    end

    describe "User Story 14" do
      describe "When there are two applications in the system for the same pet" do
        it "still sees the buttons to approve or reject the same pet in the application even though the pet has been approved/rejected in other application" do
          visit "/admin/applications/#{application_1.id}"

          expect(page).to have_button("Reject", count: 2)
          expect(page).to have_button("Approve", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)

          click_on "Approve", match: :first
          click_on "Approve"

          expect(current_path).to eq("/admin/applications/#{application_1.id}")
          expect(page).not_to have_button("Approve")
          expect(page).to have_content("Approved", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)

          visit "/admin/applications/#{application_2.id}"
          expect(page).to have_button("Reject", count: 2)
          expect(page).to have_button("Approve", count: 2)
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)
        end
      end
    end

  end
end
