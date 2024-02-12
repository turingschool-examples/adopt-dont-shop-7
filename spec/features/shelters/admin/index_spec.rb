require 'rails_helper'

RSpec.describe 'Admin Shelters Index page' do
    before(:each) do
        @aurora_shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @chicago_shelter = Shelter.create(name: "Chicago shelter", city: "Chicago, IL", foster_program: true, rank: 3)
        @vegas_shelter = Shelter.create(name: "Vegas shelter", city: "Las Vegas, NV", foster_program: false, rank: 5)
        @garfield = @aurora_shelter.pets.create(name: "garfield", breed: "shorthair", adoptable: true, age: 1)

    end
    describe 'User story 10' do
        it 'displays shelter names in reverse alphabetical order' do
            visit "/admin/shelters"

            expect(@vegas_shelter.name).to appear_before(@chicago_shelter.name)
            expect(@chicago_shelter.name).to appear_before(@aurora_shelter.name)
        end
    end
end