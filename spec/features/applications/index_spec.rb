require 'rails_helper'

RSpec.describe "application index page" do

    it 'will show all applications' do
      application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
      
      visit '/applications'
      expect(page).to have_content("Name")
      expect(page).to have_content(application.name)
      expect(page).to have_content("Street Address")
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content("Description")
      expect(page).to have_content(application.description)
      expect(page).to have_content("Pet Names")
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content("Status")
      expect(page).to have_content(application.status)
  end
end