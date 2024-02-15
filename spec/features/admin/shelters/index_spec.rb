require 'rails_helper'

RSpec.describe "AdminShelters", type: :feature do
   
    describe "admin shelters index page" do
        # User Story 10
        it 'has an index page' do
            shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
            shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
            shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

            visit '/admin/shelters'

            within "#shelter-#{shelter_1.id}" do
                expect(page).to have_content(shelter_1.name)
                expect(page).to have_content(shelter_1.city)
                expect(page).to have_content(shelter_1.rank)
            end
            
            within "#shelter-#{shelter_2.id}" do
                expect(page).to have_content(shelter_2.name)
                expect(page).to have_content(shelter_2.city)
                expect(page).to have_content(shelter_2.rank)
            end
            
            within "#shelter-#{shelter_3.id}" do
                expect(page).to have_content(shelter_3.name)
                expect(page).to have_content(shelter_3.city)
                expect(page).to have_content(shelter_3.rank)
                expect(page).to have_content(shelter_3.foster_program)
            end
        end

        # User Story 10
        it 'lists all shelters in reverse alphabetical order' do
            shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
            shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
            shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
        
            visit '/admin/shelters'

            within "#reverse_alpha_shelters" do
                expect(page).to have_content(shelter_1.name)
                expect(page).to have_content(shelter_3.name)
                expect(page).to have_content(shelter_2.name)
            end
        end

        # User Story 11
        it 'has a displays all pending applications with the shelter name' do
            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            application_1 = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
            application_2 = pet_1.adoption_applications.create!(name: "Amy", street_address: "25 Center St", city: "Atlanta", state: "GA", zip_code: 30303, description: "I make a lot of money", status: "In Progress")
            
            visit '/admin/shelters'

            # Then I see a section for "Shelters with Pending Applications"
            # And in this section I see the name of every shelter that has a pending application
            within "#shelters_pending_apps"
                expect(page).to have_content("All Shelters With")
                expect(page).to have_content(shelter.name)
                expect(page).to have_content("Mystery Building")
            end
        end
    end

