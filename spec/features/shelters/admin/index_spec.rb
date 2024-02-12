require 'rails_helper'

RSpec.describe 'Admin Shelters Index page' do
    before(:each) do
        @aurora_shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @chicago_shelter = Shelter.create(name: "Chicago shelter", city: "Chicago, IL", foster_program: true, rank: 3)
        @vegas_shelter = Shelter.create(name: "Vegas shelter", city: "Las Vegas, NV", foster_program: false, rank: 5)
        @garfield = @aurora_shelter.pets.create(name: "garfield", breed: "shorthair", adoptable: true, age: 1)

        @odell = Application.create!(name: "Odell", street_address: "123 Dog Lane", city: "Denver", state: "Colorado", zip_code: 70890, description: "Practicing for when I have kids", status: "Pending")

        @martin = Application.create!(name: "Martin", street_address: "134 Huski Lane", city: "Chicago", state: "Ilinois", zip_code: 60609, description: "I love dogs")

    end

    describe 'User story 10' do
        it 'displays shelter names in reverse alphabetical order' do
            visit "/admin/shelters"

            expect(@vegas_shelter.name).to appear_before(@chicago_shelter.name)
            expect(@chicago_shelter.name).to appear_before(@aurora_shelter.name)
        end
    end

    describe 'User story 11' do
        
        it 'displays pending applications section' do

            shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            aurora_shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
            rgv_shelter = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)

            applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
            martin = Application.create!(name: "Martin", street_address: "134 Huski Lane", city: "Chicago", state: "Ilinois", zip_code: 60609, description: "I love dogs")
            odell = Application.create!(name: "Odell", street_address: "145 Dog Lane", city: "Denver", state: "CO", zip_code: 60655, description: "Hi!")

            pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            bull_dog = martin.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true, shelter_id: aurora_shelter.id)

            visit "/admin/shelters"

            #possible within test
            expect(page).to have_content(shelter.name)
            expect(page).to have_content(aurora_shelter.name)
            expect(page).to_not have_content(rgv_shelter.name)
        end
    end
end