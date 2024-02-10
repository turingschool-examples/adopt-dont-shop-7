require 'rails_helper'

RSpec.describe 'Admin Shelters Applications Show Page' do

    #  User Story 12
    it 'has a show page' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
        application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

        visit '/admin/applications/application.id'

        expect(page).to have_content("Scrappy")
    end

    # User Story 12
    describe 'approve pets on an individual application' do

        # For every pet that the application is for, I see a button to approve the application for that specific pet
        it 'has a button to approve pets' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = pet_1.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_2 = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
        
            visit '/admin/applications/#{application_1.id}'

            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_2.name)       
        end

        it 'button click redirects to admin application show page' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = pet_1.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_2 = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            
            visit '/admin/applications/#{application_1.id}'

            expect(page).to have_button("Approve")

            click_on "Approve"

            expect(current_path).to eq('/admin/applications/#{application_1.id}')
        end

        # next to the pet approved, no button to approve
        # indicator next to the pet that they have been approved
        it 'displays updated approval for pet' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = pet_1.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_2 = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

            visit '/admin/applications/#{application_1.id}'

            expect(page).to have_button("Approve")

            click_on "Approve"
            click_on "Approve"

            expect(page).to have_content("Approved")
            expect(page).to not_have_content("Approve")
        end
    end
end