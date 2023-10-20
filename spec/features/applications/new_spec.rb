require 'rails_helper'

RSpec.describe "new application" do

  describe 'application new page' do
    it 'it will show a new application for the user to fill out' do
      application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
      
      visit '/applications/new'
      expect(page).to have_content("Name")
      expect(page).to have_content("Street Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip Code")
      expect(page).to have_content("Description")
      expect(page).to have_content("Pet Names")
      expect(page).to have_content("Status")
    end
  end
end