require 'rails_helper'

RSpec.describe 'Admin Shelters Index Page', type: :feature do
  describe 'As a visitor' do
    before do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 8)
    end

    # User Story #10. Admin Shelters Index
    it "displays pet search results with partial matches" do
      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      expect("Denver shelter").to appear_before("Aurora shelter")
    end
  end
end