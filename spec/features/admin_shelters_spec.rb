require 'rails_helper'

RSpec.describe "AdminShelters", type: :feature do
    it 'has an index page' do
        Shelter.create!
        Shelter.create!
        Shelter.create!

        #rest of set up

        visit '/admin/shelters'

        expect(page).to have_content(shelter_1.name)
        expect(page).to have_content(shelter_2.name)
        expect(page).to have_content(shelter_3.name)
        expect(page).to have_content(shelter_3.name)
        expect(page).to have_content(shelter_3.name)
        expect(page).to have_content(shelter_3.name)
        expect(page).to have_content(shelter_3.name)
    end
end