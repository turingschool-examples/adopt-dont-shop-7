require "rails_helper"

RSpec.describe "Admin Shelter Page", type: :feature do

  describe "As a visitor" do
    describe "When I visit '/admin/shelters'" do
      before(:each) do
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_2 = Shelter.create!(name: "Lakewood shelter", city: "Lakewood, CO", foster_program: true, rank: 7)
        @shelter_3 = Shelter.create!(name: "Westminster shelter", city: "Westminster, CO", foster_program: false, rank: 2)
        
      end 

      #User Story 10
      it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
        visit "/admin/shelters"

        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_3.name)

        expect(@shelter_3.name).to appear_before(@shelter_2.name)
        expect(@shelter_2.name).to appear_before(@shelter_1.name)
      end
    end 
  end 
end 