require "rails_helper"

RSpec.describe "new application form page" do

# [ ] done
# 2. Starting an Application
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
#   - Description of why I would make a good home
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
  
  describe "when io visit the pet index page" do
    it "displays a link to start an application" do
      visit "/pets"
      expect(page).to have_link("Start an Application", href: "/applications/new")
    end
  
    it "takes user to new application page" do
      visit "/pets"

      click_link "Start an Application"
    
      expect(page).to have_current_path("/applications/new")
    end

    it "has a form to fill out and when user clicks submit they are redirected to new application show page and see new content" do
      visit "/applications/new"

      fill_in "name", with: "Test"
      fill_in "street_address", with: "Test_2"
      fill_in "city", with: "Test 3"
      fill_in "state", with: "Test 4"
      fill_in "zipcode", with: "Test 5"
      fill_in "description", with: "Test 6"

      click_button "Submit"

      expect(page).to have_content("Test")


      
    end
  end
end