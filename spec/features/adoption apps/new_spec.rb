require "rails_helper"

RSpec.describe "The Adoption Application", type: :feature do
  describe "#new page" do
    before(:each) do
      test_data
    end
      #user story 3
      it "displays an error if the form is not completely filled out" do
        visit "/adoption_apps/new"

        click_on "Submit Application"

        expect(page).to have_content("Application not created: Required information missing.")
        expect(page).to have_button("Submit Application")
        
        fill_in "Name", with: "Suzie"
        click_on "Submit Application"
        expect(page).to have_content("Application not created: Required information missing.")

        fill_in "Name", with: "Suzie"
        fill_in "Zip code", with: "80212"
        click_on "Submit Application"
        expect(page).to have_content("Application not created: Required information missing.")
    end
  end
end