require "rails_helper"

RSpec.describe "Admin Shelter Index page", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Updog Pet Rescue", city: "Queens, NY", foster_program: false, rank: 7)
      
    @peter = Application.create!(name: "Peter Griffin", street: "200 Park Road", city: "Quahog", state: "MA", zip_code: "09876", description: "I like animals", status: "In Progress")
    
    @bare = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    @lobster = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_3.id)
    
    @bare_app = @homer.pet_applications.create!(pet_id: @bare.id, status: "Pending")
    @lobster_app = @homer.pet_applications.create!(pet_id: @lobster.id, status: "In Progress")
  end

  
  describe "When I visit the admin shelter index ('/admin/shelters')" do
    it "I see a section for 'Pending Applications'" do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications")
    end

    it "In the 'Pending Applications' section I see the name of every shelter with pending application" do
      visit "/admin/shelters"
  
      within("#pending-applications") do
        expect(page).to have_content(@shelter_1.name)
        expect(page).not_to have_content(@shelter_2.name)
        expect(page).not_to have_content(@shelter_3.name)
      end
    end      
  end
end
