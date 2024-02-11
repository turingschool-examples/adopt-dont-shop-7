require 'rails_helper'

RSpec.describe 'Admin Shelters Applications Show Page' do

    #  User Story 12
    it 'has a show page' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
        application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

        visit "/admin/applications/#{application.id}"

        expect(page).to have_content("Scrappy")
    end

    # User Story 12
    describe 'approve pets on an individual application' do

        # For every pet that the application is for, I see a button to approve the application for that specific pet
        it 'has a button to approve pets' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.pets << [pet_1]

            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_button("Approve")
        end

        it 'button click redirects to admin application show page' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            # pet_2 = shelter.pets.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.pets << [pet_1]
            
            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_button("Approve")

            click_on "Approve"

            expect(current_path).to eq("/admin/applications/#{application_1.id}")
            expect(page).not_to have_button("Approve")
        end

        # next to the pet approved, no button to approve
        # indicator next to the pet that they have been approved
        it 'displays updated approval for pet' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.pets << [pet_1]

            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_button("Approve")
            save_and_open_page

            click_on "Approve"

            expect(page).to have_content(pet_1.adoptable)
            expect(page).not_to have_button("Approve")
        end
    end

    # User Story 13
    xdescribe 'rejecting a pet for adoption' do
        it 'has a button to reject pets' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.pets << [pet_1]

            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_button("Reject")
        end

        it 'button click redirects to admin application show page' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            # pet_2 = shelter.pets.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.pets << [pet_1]
            
            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_button("Reject")

            click_on "Reject"

            expect(current_path).to eq("/admin/applications/#{application_1.id}")
            expect(page).not_to have_button("Reject")
        end

        # next to the pet rejected, no button to approve or reject
        # indicator next to the pet that they have been approved
        it 'displays updated reject for pet' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.pets << [pet_1]

            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_button("Reject")
            save_and_open_page

            click_on "Reject"

            expect(page).to have_content(pet_1.adoptable)
            expect(page).not_to have_button("Reject")
        end
    end
end