require "rails_helper"

RSpec.feature "the application show" do
  describe 'when visiting /applications/:id/show' do
    scenario 'displays all application info' do


      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", pet_names: "Zeus, Demeter", status: "In Progress")

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.applicant_name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)
    end
  end
end

