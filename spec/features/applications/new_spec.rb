require "rails_helper"

describe "new application page" do
  before (:each) do
    #
  end
  describe "As a visitor, when I visit the new application page" do
    describe "And I fail to fill in any of the form fields and I click submit" do
      it "Then I am taken back to the new applications page And I see a message that I must fill in those fields." do
        visit "/applications/new"
        expect(current_path).to eq("/applications/new")
        expect(page).to have_css("#new_application")
        
        click_button("Submit")
        
        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Application not saved. Please fill in all fields.")
      end
    end
  end
end