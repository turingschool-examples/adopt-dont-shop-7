require 'rails_helper'

RSpec.describe "Application show" do
    before(:each) do
        @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: 1)
        @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: 1)
        @applicant_1 = Applicant.create!(name: "Lance", street_address: "123 sesame street", city: "Brooklyn", state: "New York", zip_code: "10012", description: "I like dogs", pet_names: "Lucille Bald", status: "In Progress")
        @applicant_2 = Applicant.create!(name: "Nico", street_address: "125 sesame way", city: "Miami", state: "Florida", zip_code: "63016", description: "I have an unlimited supply of poop bags", pet_names: "Lobster", status: "In Progress") 
    
    end

    it 'shows the name of the applicant and attributes' do
        visit "/applicant/#{@applicant_1.id}"

        expect(page).to have_content(@applicant_1.name)
        expect(page).to have_content(@applicant_1.street_address)
        expect(page).to have_content(@applicant_1.city)
        expect(page).to have_content(@applicant_1.state)
        expect(page).to have_content(@applicant_1.zip_code)
        expect(page).to have_content(@applicant_1.description)
        expect(page).to have_link("Pet Names")
        expect(page).to have_content(@applicant_1.status)

       
    end
end