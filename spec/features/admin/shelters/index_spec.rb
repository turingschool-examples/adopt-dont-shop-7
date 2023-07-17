require "rails_helper"

RSpec.describe "admin index page", type: :feature do 
  describe "as a visitor when I visit the admin shelter index" do 
    before :each do
    @shelter_1 = Shelter.create!(name: 'Cat Shelter for Good', city: 'Denver', foster_program: true, rank: 1)
    @shelter_2 = Shelter.create!(name: 'Help Dogs Shelter', city: 'Austin', foster_program: false, rank: 2)
    @shelter_3 = Shelter.create!(name: "Adopt Don't Shop Shelter", city: 'Dallas', foster_program: true, rank: 3)
    end
    
    #US_10
    it "shows all shelters in the system listed in reverse alphabetical order" do 
      visit "/admin/shelters"
      
      expect("Help Dogs Shelter").to appear_before("Cat Shelter for Good")
      expect("Cat Shelter for Good").to appear_before("Adopt Don't Shop Shelter")
    end
  end
end