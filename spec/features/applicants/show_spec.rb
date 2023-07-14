require 'rails_helper'

RSpec.describe "Applicants Show" do

    before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @applicant_1 = Applicant.create(name: "Ian", street_address: "4130 cleveland ave", city: "New Orleans", state: "louisiana", zip_code: 70119, description: "I wanna have cat", status: "In Progress")
        @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
        @applicant_pet = ApplicantPet.create(pet_id: @pet_1.id, applicant_id: @applicant_1.id)
    end

    describe "shows the applicant and its attributes including pets" do
        it 'shows the applicant' do
            visit "/applicants/#{@applicant_1.id}"

            expect(page).to have_content(@applicant_1.name)
            expect(page).to have_content(@applicant_1.street_address)
            expect(page).to have_content(@applicant_1.city)
            expect(page).to have_content(@applicant_1.state)
            expect(page).to have_content(@applicant_1.zip_code)
            expect(page).to have_content(@applicant_1.description)
            expect(page).to have_content(@applicant_1.status)
            expect(page).to have_link("#{@pet_1.name}")

            click_link "#{@pet_1.name}"

            expect(current_path).to eq("/pets/#{@pet_1.id}")
        end
    end
end