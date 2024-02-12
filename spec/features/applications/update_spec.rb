require 'rails_helper'
# 3. Starting an Application, Form not Completed

RSpec.describe "applications update" do
    it 'redirects to the new applications page if form is not completed after clicking submit' do
        # When I visit the new application page
        visit "/applications/new"
        # And I fail to fill in any of the form fields
        fill_in "Name", with: ""
        # And I click submit
        click_button "submit"
        # Then I am taken back to the new applications page
        expect(page).to have_current_path("/applications/new")
        # And I see a message that I must fill in those fields.
        expect(page).to have_content("Error: Name can't be blank")
    end    
end
