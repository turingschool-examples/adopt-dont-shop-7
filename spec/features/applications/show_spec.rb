require 'rails_helper'

RSpec.describe "Application show" do
    before(:each) do
        @applicant_1 = Applicant.create!(name: "Lance", street_address: "123 sesame street", city: "Brooklyn", state: "New York", zip_code: "10012")
        @applicant_2 = Applicant.create!(name: "Nico", street_address: "125 sesame way", city: "Miami", state: "Florida", zip_code: "63016") 
        #lance database @applicant_2 = id => 1
    end

    it 'shows the name of the applicant and attributes' do
        visit "/applicant/#{@applicant_1.id}"

        expect(page).to have_content(@applicant_1.name)
        expect(page).to have_content(@applicant_1.street_address)
        expect(page).to have_content(@applicant_1.city)
        expect(page).to have_content(@applicant_1.state)
        expect(page).to have_content(@applicant_1.zip_code)
        expect(page).to_not have_content(@applicant_2.name)
        expect(page).to_not have_content(@applicant_2.street_address)
        expect(page).to_not have_content(@applicant_2.city)
        expect(page).to_not have_content(@applicant_2.state)
        expect(page).to_not have_content(@applicant_2.zip_code)
    end

    it 'shows desciption for why this is a good home' do 
        visit "/applicant/#{@applicant_1.id}"

        expect(page).to have_content(@applicant_1.desciption)
        #expect(page).to_not have_content(@applicant_2.desciption)
    end
end