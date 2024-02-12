require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do

    #  User Story 12
    it 'has a show page' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet_1 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
        application = pet_1.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

        visit "/admin/applications/#{application.id}"

        # Added more stuff to the test and to the page
        expect(page).to have_content("Scrappy")
        expect(page).to have_content(application.name)
        expect(page).to have_content(application.street_address)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip_code)
        expect(page).to have_content(application.description)
    end

    it 'has a link to the pet show page' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet_1 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
        application = pet_1.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")

        visit "/admin/applications/#{application.id}"

        click_link("Scrappy")

        expect(current_path).to eq("/pets/#{pet_1.id}")
    end

    # User Story 12
    describe 'approve pets on an individual application' do
        # For every pet that the application is for, I see a button to approve the application for that specific pet
        it 'has a button to approve pets' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.add_pet_to_app(pet_1.id)

            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_button("Approve")
        end

        it 'button click redirects to admin application show page' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            # pet_2 = shelter.pets.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_1.add_pet_to_app(pet_1.id)
            
            visit "/admin/applications/#{application_1.id}"

            expect(page).to have_button("Approve")

            click_on "Approve"

            expect(current_path).to eq("/admin/applications/#{application_1.id}")
            expect(page).not_to have_button("Approve")
            expect(page).to have_content("#{pet_1.name} already approved!")
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
            # save_and_open_page

            click_on "Approve"
            # save_and_open_page
            expect(page).to have_content("#{pet_1.name} already approved!")
            expect(page).not_to have_button("Approve")
        end
    end

    # User Story 13
    describe 'rejecting a pet for adoption' do
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
            expect(page).to have_content("#{pet_1.name} already rejected!")
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
            # save_and_open_page

            click_on "Reject"

            expect(page).to have_content(pet_1.adoptable)
            expect(page).not_to have_button("Reject")
        end
    end
    
    describe 'content' do
        it 'has a section to add a Pet to the application' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

            visit "/admin/applications/#{application.id}"

            expect(page).to have_content("Add Pets to this Application")
            expect(page).to have_content("Search Pet by Name")

            fill_in "search", with: "Sc"
            click_on "Search"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_1.breed)
            expect(page).to have_content(pet_1.age)
            expect(page).to have_content(pet_1.adoptable)
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_2.breed)
            expect(page).to have_content(pet_2.age)
            expect(page).to have_content(pet_2.adoptable)

            expect(page).to have_button("#{pet_1.name}")
        end

        it 'is has partial matches' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "SCOOBY", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "ScRaPpY", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

            visit "/admin/applications/#{application.id}"

            expect(page).to have_content("Add Pets to this Application")
            expect(page).to have_content("Search Pet by Name")

            fill_in "search", with: "sc"
            click_on "Search"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_1.breed)
            expect(page).to have_content(pet_1.age)
            expect(page).to have_content(pet_1.adoptable)
            expect(page).to have_content(pet_2.name)
            expect(page).to have_content(pet_2.breed)
            expect(page).to have_content(pet_2.age)
            expect(page).to have_content(pet_2.adoptable)

            expect(page).to have_button("Adopt #{pet_1.name}")
        end

        it 'display a button to adopt the pet under each pet' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

            visit "/admin/applications/#{application.id}"

            fill_in "search", with: "scooby"
            click_button "Search"

            expect(page).to have_button("Adopt Scooby")
        end

        it 'shows added pets to adoption application' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

            visit "/admin/applications/#{application.id}"

            fill_in "search", with: "scooby"
            click_button "Search"

            click_button "Adopt Scooby"
            
            fill_in "search", with: "a"

            expect(page).to have_content(pet_1.name)
        end
    end
end