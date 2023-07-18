require "rails_helper"

RSpec.describe "Admin Shelter Index page", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "Mystery Building", city: "Irvine, CA", foster_program: false, rank: 9)
    @shelter_3 = Shelter.create!(name: "Dumb Friends League", city: "Denver, CO", foster_program: true, rank: 10)
  
    @mr_ape = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "CO", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    
    @lucille = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "Sphynx", name: "Lucille Bald")
    @scooby = @shelter_3.pets.create!(adoptable: true, age: 2, breed: "Great Dane", name: "Scooby")
    
    @lucille_app = @mr_ape.application_pets.create!(pet_id: @lucille.id, status: "Pending")
    @scooby_app = @mr_ape.application_pets.create!(pet_id: @scooby.id, status: "In Progress")
  end

  describe "As a visitor" do
    describe "When I visit the admin shelter index ('/admin/shelters')" do

      # 10. Admin Shelters Index
      it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
        visit "/admin/shelters"

        within ("#all-shelters") do
          expect(page).to have_content(@shelter_1.name)
          expect(page).to have_content(@shelter_2.name)
          expect(page).to have_content(@shelter_3.name)
  
          expect(@shelter_2.name).to appear_before(@shelter_1.name)
          expect(@shelter_2.name).to appear_before(@shelter_1.name)
  
          expect(@shelter_3.name).to appear_before(@shelter_1.name)
        end
      end

      it "Then I see a section for 'Pending Applications'" do
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
end