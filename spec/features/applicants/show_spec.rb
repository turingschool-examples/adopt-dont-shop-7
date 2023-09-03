require "rails_helper"

RSpec.describe "Applicants Show Page", type: :feature do
  before(:each) do
    @bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")
  end

  describe "As a visitor" do
    describe "When I visit an applicants show page" do
      it "displays the name, full address, description, pets that its for, and the app status" do
        visit "/applicants/#{@bob.id}"

        expect(page).to have_content("#{@bob.name}")
        expect(page).to have_content("#{@bob.street_address}")
        expect(page).to have_content("#{@bob.city}")
        expect(page).to have_content("#{@bob.state}")
        expect(page).to have_content("#{@bob.zip_code}")
        expect(page).to have_content("#{@bob.description}")
        expect(page).to have_content("#{@bob.application_status}")
      end
    end
  end
end