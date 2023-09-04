require "rails_helper"

RSpec.describe "New Application", type: :feature do
  describe "as a visitor, when I visit the pet index page" do
    describe "then I see a link to 'Start an Application', when I click this link" do
      describe "then I am taken to the new application page where I see a form, I fill in this form with my: name, street address, city, state, zip code, description and I click submit" do
        it "I am taken to the new application's show page, I see the information I put in the form, and an indicator that the application is 'In Progress'" do
          visit "/pets/"

          click_link("Start an Application")

          expect(current_path).to eq("/applications/new")

          expect(page).to have_content("Name:")
          expect(page).to have_content("Street Address:")
          expect(page).to have_content("City:")
          expect(page).to have_content("State:")
          expect(page).to have_content("Zip Code:")
          expect(page).to have_content("Description:")

          fill_in "name", with: "John Smith"
          fill_in "street_address", with: "1234 Lane Street"
          fill_in "city", with: "Happy City"
          fill_in "state", with: "CO"
          fill_in "zip_code", with: "80111"
          fill_in "description", with: "I want an animal"

          click_button("Submit")

          expect(page).to have_content("John Smith")
          expect(page).to have_content("Street Address: 1234 Lane")
          expect(page).to have_content("City: Happy City")
          expect(page).to have_content("State: CO")
          expect(page).to have_content("Zip Code: 80111")
          expect(page).to have_content("Description: I want an animal")
          expect(page).to have_content("Pets:")
          expect(page).to have_content("Status: In Progress")
        end
      end
    end
  end

  describe " As a visitor when I visit the new application page" do
    describe "And I fail to fill in any of the form fields and I click submit" do
      it "I am taken back to the new applications page and I see a message that I must fill in those fields." do
        visit "/applications/new"

        click_button("Submit")

        expect(page).to have_content("You must fill in all fields")
      end
    end
  end
end
