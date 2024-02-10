require 'rails_helper'

RSpec.describe "AdminShelters", type: :feature do
   
    # User Story 10
    it 'has an index page' do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

        visit '/admin/shelters'

        save_and_open_page

        expect(page).to have_content(shelter_1.name)
        expect(page).to have_content(shelter_2.name)
        expect(page).to have_content(shelter_3.name)
        # expect(page).to have_content(shelter_3.city)
        # expect(page).to have_content(shelter_1.city)
        # expect(page).to have_content(shelter_2.rank)
        # expect(page).to have_content(shelter_3.foster_program)
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
end