require "rails_helper"

RSpec.describe "create new application", type: :feature do
  describe "US2-Starting an Application" do
    describe "visit the pet index, see a link to Start an Application" do
      describe "click the link, then I am taken to the new application page where I see a form" do
        describe "fill in this form with all the required fields and click submit" do
          it "takes me to the new application show page and I see all the required fields" do
            visit "/pets"

            expect(page).to have_link("Start an Application")
            click_link("Start an Application")

            expect(current_path).to eq("/applications/new")

            expect(page).to have_content("Name:")
            expect(page).to have_content("Street Address:")
            expect(page).to have_content("City:")
            expect(page).to have_content("State:")
            expect(page).to have_content("Zip Code:")
            expect(page).to have_content("Description")

            fill_in "name",	with: "Jimmy John"
            fill_in "street_address",	with: "111 lonely road"
            fill_in "city",	with: "John City"
            fill_in "state",	with: "AR"
            fill_in "zip_code",	with: "90909"
            fill_in "description",	with: "I like animals"

            click_button "Submit"

            expect(page).to have_content("Jimmy John")
            expect(page).to have_content("Applicant Address: 111 lonely road, John City, AR, 90909")
            expect(page).to have_content("I like animals")
            expect(page).to have_content("In Progress")
          end
        end
      end
    end
  end

  describe "US3-Starting an Application, Form not complete" do
    describe "When I visit the new application page" do
        describe "I fail to fill in any of the form fields And I click submit" do
          it "I am taken back to the new applications page, I see a message that I must fill in those fields." do
            visit "/applications/new"

            expect(current_path).to eq("/applications/new")

            expect(page).to have_content("Name:")
            expect(page).to have_content("Street Address:")
            expect(page).to have_content("City:")
            expect(page).to have_content("State:")
            expect(page).to have_content("Zip Code:")
            expect(page).to have_content("Description")

            fill_in "name",	with: "Jimmy John"
            fill_in "street_address",	with: "111 lonely road"
            fill_in "city",	with: "John City"
            fill_in "state",	with: "AR"
            fill_in "zip_code",	with: "90909"

            click_button "Submit"
            expect(current_path). to eq("/applications/new")
            expect(page).to have_content("Error: Fill in all fields")
          end
        end
      end
  end
end
