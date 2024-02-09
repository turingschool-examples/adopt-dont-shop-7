require 'rails_helper'

RSpec.describe 'New Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      
    end
    
    # 3. Starting an Application, Form not Completed
    it 'return an incomplete form' do
      # When I visit the new application page
      visit "/applications/new"
      # And I fail to fill in any of the form fields
      fill_in("name", with: "Jake")
      # And I click submit
      click_button("submit")
      # Then I am taken back to the new applications page
      expect(current_path).to eq("/applications/new")
      # And I see a message that I must fill in those fields.
      expect(page).to have_content("Missing required inputs")
    end
  end
end