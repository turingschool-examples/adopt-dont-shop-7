require 'rails_helper'

RSpec.describe 'New Application Form', type: :feature do
  describe 'As a Visitor' do
    before(:each) do

    end
    #User Story 2 Starting an Application
    it "displays link to New application form" do
      # As a visitor
      # When I visit the pet index page and click link "Start an Application"
      visit "/pets/"
      click_link("New Application")

      # Then I am taken to the new application page where I see a form
      expect(current_path).to eq("/applications/new")

      expect(page).to have_content("New Application")
      expect(find("form")).to have_field(:name)
      expect(find("form")).to have_field(:street_address)
      expect(find("form")).to have_field(:city)
      expect(find("form")).to have_field(:state)
      expect(find("form")).to have_field(:zip_code)
      expect(find("form")).to have_field(:adopting_reason)
      
      # When I fill in this form with my:
      #   - Name
      fill_in(:name, with: "Mark")
      #   - Street Address
      fill_in(:street_address, with: '687 Folsom Ave')
      #   - City
      fill_in(:city, with: "Denver")
      #   - State
      fill_in(:state, with: "CO")
      #   - Zip Code
      fill_in(:zip_code, with: "80024")
      #   - Description of why I would make a good home
      fill_in(:adopting_reason, with: "Lots of love to give, active life, need of company")

      # And I click submit
      click_button("Submit")
      # Then I am taken to the new application's show page
      # expect(current_path).to eq("/applications/id")

      # And I see my Name, address information, and description of why I would make a good home
      expect(page).to have_content("Mark")
      expect(page).to have_content("687 Folsom Ave, Denver, CO, 80024")
      expect(page).to have_content("Description of why the applicant says they'd be a good home for this pet(s): Lots of love to give, active life, need of company")
      
      # And I see an indicator that this application is "In Progress"
      expect(page).to have_content("In Progress")
    end

    #User Story# 3. Starting an Application, Form not Completed
    it "takes me back to new applications page when I fail to fill in any of the form fields" do
      # As a visitor
      # When I visit the new application page
      visit "/applications/new"
      
      # And I fail to fill in any of the form fields      
      # And I click submit
      click_button("Submit")
      
      # Then I am taken back to the new applications page
      expect(current_path).to eq("/applications/new")
      # And I see a message that I must fill in those fields.
      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_content("Street address can't be blank")
      expect(page).to have_content("City can't be blank, State can't be blank")
      expect(page).to have_content("Zip code is not a number")
      expect(page).to have_content("Adopting reason can't be blank")
    end
  end
end