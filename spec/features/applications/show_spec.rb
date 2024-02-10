require 'rails_helper'

RSpec.describe "Application show" do
    before(:each) do
    #     @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    #     @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: 1)
    #     @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: 1)
        @application_1 = Application.create!(name: "Lance", street_address: "123 sesame street", city: "Brooklyn", state: "New York", zip_code: "10012", description: "I like dogs", status: "In Progress")
        @application_2 = Application.create!(name: "Nico", street_address: "125 sesame way", city: "Miami", state: "Florida", zip_code: "63016", description: "I have an unlimited supply of poop bags", status: "In Progress") 
    
    end

    it 'shows the name of the applicant and attributes' do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.street_address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zip_code)
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@application_1.status)
        
        expect(page).to_not have_content(@application_2.name)
        expect(page).to_not have_content(@application_2.street_address)
        expect(page).to_not have_content(@application_2.city)
        expect(page).to_not have_content(@application_2.state)
        expect(page).to_not have_content(@application_2.zip_code)
        expect(page).to_not have_content(@application_2.description)
    end

    xit 'links to dog show page' do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_link()
    end
end