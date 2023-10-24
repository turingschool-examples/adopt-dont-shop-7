require "rails_helper"

RSpec.describe "Admin Shelter Page", type: :feature do

  describe "As a visitor" do
    describe "When I visit '/admin/shelters'" do
      before(:each) do
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_2 = Shelter.create!(name: "Lakewood shelter", city: "Lakewood, CO", foster_program: true, rank: 7)
        @shelter_3 = Shelter.create!(name: "Westminster shelter", city: "Westminster, CO", foster_program: false, rank: 2)

        @application_1 = Application.create(name: "Julie Johnson", street_address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", status: "In Progress")

        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "doberman", name: "Auggie", shelter_id: @shelter_1.id)
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

      #User Story 11
      describe "Then I see a section for 'Shelters with Pending Applications'" do
        it "I see a section with the name of every shelter that has a pending application" do
          visit "/applications/#{@application_1.id}"

          fill_in "Search for Pets", with: "Auggie"

          click_button "Submit"

          click_button "Adopt this Pet"

          fill_in "Why would you make a good owner for these pet(s)?", with: "I've always loved dogs."

          click_button "Submit Application"
          
          expect(page).to have_content("Pending")

          visit "/admin/shelters"

          expect(page).to have_content("Shelters with Pending Applications")
          expect(page).to have_content("Aurora shelter")
        end
      end 
    end 
  end 
end 