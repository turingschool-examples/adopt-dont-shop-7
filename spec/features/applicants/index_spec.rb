require "rails_helper"

RSpec.describe "Applicants Show Page", type: :feature do
  before(:each) do
    @bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")
  end

  describe "As a visitor" do
    describe "When I visit the applicants index page" do
      it "displays all applicants who have applications in progress or submitted and their attributes" do
        visit "/applicants"

        expect(page).to have_content("Applicant IDs")
        expect(page).to have_content("#{@bob.id}")
        expect(page).to have_link("Applicants Show page")
        expect(page).to have_content("#{@bob.name}")
        expect(page).to have_content("Address:")
        expect(page).to have_content("#{@bob.street_address}")
        expect(page).to have_content("#{@bob.city}")
        expect(page).to have_content("#{@bob.zip_code}")
        expect(page).to have_content("Why I would make a good home:")
        expect(page).to have_content("#{@bob.description}")
        expect(page).to have_content("Application Status:")
        expect(page).to have_content("#{@bob.application_status}")
      end

      describe "And I click the link 'Applicants Show page'" do
        it "takes me to the Applicants Show page" do
          visit "/applicants"

          click_on "Applicants Show page"

          expect(current_path).to eq("/applicants/#{@bob.id}")
        end
      end
    end
  end
end