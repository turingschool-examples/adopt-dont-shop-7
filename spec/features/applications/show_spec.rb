require "rails_helper"

RSpec.describe "As a visitor" do
  # 1. Application Show Page
  describe "When I visit an applications show page" do
    it "Then I can see the following" do
      application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "in progress")
     
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.application_status)
    end
  end
end
