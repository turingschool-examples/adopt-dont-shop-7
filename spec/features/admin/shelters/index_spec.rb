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


      # For this story, you should fully leverage ActiveRecord methods in your query.

      # 11. Shelters with Pending Applications

      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      # Then I see a section for "Shelters with Pending Applications"
      # And in this section I see the name of every shelter that has a pending application


      describe "I see a section for shelters that have pending applications" do 
        it "displays the name of every shelter that has a pending application" do 
          application_1 = Application.create!(name: "Jon Jones", street_address: "4201 UFC Way", city: "Las Vegas", state: "NV", zip_code: 99999, description: "I'm a fighter but not a dog fighter", status: "Pending")
          application_2 = Application.create!(name: "Derek Lewis", street_address: "777 Beast Lane", city: "Houston", state: "TX", zip_code: 76543, description: "I really need a friend", status: "Pending")
      
          pet_1 = @shelter_1.pets.create(name: "Mr. Bill", breed: "German Shepherd", age: 10, adoptable: true)
          pet_2 = @shelter_2.pets.create(name: "Karen", breed: "Pit Bull", age: 10, adoptable: false)
      
          ApplicationPet.create!(application: application_1, pet: pet_1, status: "Pending")
          ApplicationPet.create!(application: application_2, pet: pet_2, status: "Pending")
          
          visit "/admin/shelters"
      
          expect(page).to have_content("Shelters with Pending Applications")
      
          within "#pending_applications_section" do
            expect(page).to have_content(@shelter_1.name)
            expect(page).to have_content(@shelter_2.name)
          end
        end
      end
      
    end
  #   describe "I see a section for shelters that have pending applications" do 
  #     it "in this section I see a name of every shelter that has a pending application" do 
        
  #       application_1 = Application.create!(name: "Jon Jones", street_address: "4201 UFC Way", city: "Las Vegas", state: "NV", zip_code: 99999, description: "I'm a fighter but not a dog fighter", status: "Pending")
  #       application_2 = Application.create!(name: "Derek Lewis", street_address: "777 Beast Lane", city: "Houston", state: "TX", zip_code: 76543, description: "I really need a friend", status: "Pending")
  
  #       pet_1 = @shelter_1.pets.create(name: "Mr. Bill", breed: "German Shepherd", age: 10, adoptable: true)
  #       pet_2 = @shelter_2.pets.create(name: "Karen", breed: "Pit Bull", age: 10, adoptable: false)
  
  #       ApplicationPet.create!(application: application_1, pet: pet_1, status: "Pending")
  #       ApplicationPet.create!(application: application_2, pet: pet_2, status: "Pending")
        
  #       visit "/admin/shelters"
  
  #       expect(page).to have_content("Shelters with Pending Applications")

  #       within "#pending_applications" do
  #         expect(page).to have_content(@shelter_1.name)
  #         expect(page).to have_content(@shelter_2.name)
  #       end
  #     end
  #   end
  # end
end