require 'rails_helper'

RSpec.describe "the applications index page" do 

  #   US_2. Starting an Application

  describe "When I visit the pet index page" do 
    it "I see a link to 'Start an Application'" do 
      visit "/pets"
      
      expect(page).to have_link("Start an Application")
      
      click_link("Start an Application")

      expect(current_path).to eq("/applications/new")
    end
  end


  # Then I am taken to the new application's show page
  # And I see my Name, address information, and description of why I would make a good home
  # And I see an indicator that this application is "In Progress"

  describe "When I fill in the form with my information and click submit" do 
    it "I am taken to the new application's show page" do 

      visit "/applications/new" 

      fill_in :name, with: "John Doe"
      fill_in :street_address, with: "123 Main St"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip_code, with: "80202"
      fill_in :description, with: "I love animals"
      
      click_button("Submit")
    
      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content("Name: John Doe")
      expect(page).to have_content("Street Address: 123 Main St")
      expect(page).to have_content("City: Denver")
      expect(page).to have_content("State: CO")
      expect(page).to have_content("Zip Code: 80202")
      expect(page).to have_content("Description: I love animals")
      expect(page).to have_content("Status: In Progress")
    end
  end


#   [ ] done

# 3. Starting an Application, Form not Completed

# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.
  describe "When I fail to fill in any of the form fields" do
    it "redirects me back to the applications page and I see a message that I must fill in those fields" do

      application = Application.new
      application.description = ''
      visit applications_new_path

      fill_in :name, with: "John Doe"
      fill_in :street_address, with: "123 Main St"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip_code, with: "80202"
      fill_in :description, with: ''
      click_button("Submit")

      # save_and_open_page
      expect(current_path).to eq(applications_new_path)
      expect(application).to_not be_valid
      expect(application.errors[:description]).to have_content("can't be blank")
    end
  end
end