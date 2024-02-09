require 'rails_helper'

RSpec.describe "Application New Page" do
  describe "as a visitor" do
    let!(:application_1) {Application.create(name: "Francis", street_address: "600 N 1st Ave", city: "Minneapolis", state: "MN", zip_code: "55403", description: "I want a cat named Taco")}

    before do
      visit "/applications/new"
    end

    describe "User Story 2 - new application form" do
      it "displays form" do
        expect(page).to have_field("Applicant's Name")
        expect(page).to have_field("Street Address")
        expect(page).to have_field("City")
        expect(page).to have_field("State")
        expect(page).to have_field("Zip Code")
        expect(page).to have_field("Reason why you want to adopt")
      end

      it "redirects completed form to application's show page" do
        fill_in "Applicant's Name", with: "Francis"
        fill_in "Street Address", with: "600 N 1st Ave"
        fill_in "City", with: "Minneapolis"
        fill_in "State", with: "MN"
        fill_in "Zip Code", with: "55403"
        fill_in "Reason why you want to adopt", with: "I want a cat named Taco"

        click_on "Create Application"

        expect(current_path).to eq("/applications/#{Application.last.id}")
        save_and_open_page
        expect(page).to have_content(application_1.name)
        expect(page).to have_content(application_1.street_address)
        expect(page).to have_content(application_1.description)
        expect(page).to have_content("in_progress")
      end
    end

    describe "User Story 3" do
      describe "When I visit the new application page" do
        it "can not submit the application without filling any form fields" do
          click_on "Create Application"

          expect(current_path).to eq("/applications/new")
          expect(page).to have_content("Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank")
          expect(page).to have_button("Create Application")
        end
      end
    end
  end
end
