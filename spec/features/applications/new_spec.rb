require "rails_helper"

RSpec.describe "the New application page", type: :feature do
  describe "As a visitor" do
    describe "when I visit the new application page" do

      #User Story 2
      it "after I click the 'Start an Application' link, I see a form with the following attributes" do
          
        visit "/applications/new"

        fill_in("Name", with: "Joey Jones")
        fill_in("Address", with: "100 Apple Ave")
        fill_in("City", with: "Orlando")
        fill_in("State", with: "FL")
        fill_in("Zipcode", with: "56987")
        fill_in("Description", with: "I have three other dogs to be friends with.")
        click_button("Submit")

        expect(current_path).not_to eq("/applications/new")

        expect(page).to have_content("Joey Jones")
        expect(page).to have_content("100 Apple Ave")
        expect(page).to have_content("Orlando")
        expect(page).to have_content("FL")
        expect(page).to have_content("56987")
        expect(page).to have_content("I have three other dogs to be friends with.")
        expect(page).to have_content("In Progress")
      end

      #User Story 3
      it "I fail to fill in any of the form fields, click submit and taken back to new application page" do
        
        visit "/applications/new"

        expect(page).to have_content("Name")
        expect(page).to have_content("Street Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zipcode")
        expect(page).to have_content("Description")

        fill_in("Name", with: "Joey Jones")
        fill_in("Address", with: "100 Apple Ave")
        fill_in("City", with: "Orlando")

        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Please Fill In All Fields")
      end
    end 
  end 
end 