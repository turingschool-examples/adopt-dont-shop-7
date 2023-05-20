require "rails_helper"

RSpec.describe "Application show page" do
  describe 'As a visitor' do
    describe 'When I visit the application show page' do
      before(:each) do
        @joey = Application.create!(name: "Joey", address: "73 Shifty St", city: "Oakland", state: "MA", zip_code: "09342", description: "I'm a good people, totally not robot", status: "Rejected" )
      end
      it 'has the name of the applicant' do
        visit "/applications/#{@joey.id}"
        save_and_open_page
        expect(page).to have_content("Name: #{@joey.name}")
      end

      it 'has the address of the applicant' do
        visit "/applications/#{@joey.id}"

        expect(page).to have_content("Address: #{@joey.address}")
        expect(page).to have_content("City: #{@joey.city}")
        expect(page).to have_content("State: #{@joey.state}")
        expect(page).to have_content("Zip Code: #{@joey.zip_code}")
      end

      it 'has the description of the applicant' do
        visit "/applications/#{@joey.id}"

        expect(page).to have_content("Why I would be a good pet owner: #{@joey.description}")
      end

      it 'has the description of the applicant' do
        visit "/applications/#{@joey.id}"

        expect(page).to have_content("Status: #{@joey.status}")
      end
    end
  end
end
