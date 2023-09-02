require "rails_helper"

RSpec.feature "the application show" do
  describe 'when visiting /applications/:id/show' do
    scenario 'displays all application info' do


      application = Application.create!(applicant_name: "Thomas Jefferson", address: "123 Main St., Boston, MA, 12345", description: "I'm on a fiver", pet_names: "Zeus, Demeter", status: "In Progress")

      visit "/applications/#{application.id}"
      save_and_open_page

      expect(page).to have_content(application.applicant_name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)
    end
  end
end

