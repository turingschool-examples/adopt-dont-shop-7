require "rails_helper"

RSpec.describe "the New application page", type: :feature do
  describe "As a visitor" do
    describe "when I visit the new application page" do

      #User Story 2
      it "after I click the 'Start an Application' link, I see a form with the following attributes" do
        # application = PetApplication.create
          
        visit "/applications/new"

        fill_in("Name", with: "Joey Jones")
        fill_in("Address", with: "100 Apple Ave")
        fill_in("City", with: "Orlando")
        fill_in("State", with: "FL")
        fill_in("Zipcode", with: "56987")
        fill_in("Description", with: "I have three other dogs to be friends with.")

        click_button("Submit")

        expect(current_path).not_to eq("/applications/new")

        # save_and_open_page
        expect(page).to have_content("Joey Jones")
        expect(page).to have_content("100 Apple Ave Orlando, FL 5687")
        expect(page).to have_content("I have three other dogs to be friends with.")
        expect(page).to have_content("In Progress")
      end
    end 
  end 
end 