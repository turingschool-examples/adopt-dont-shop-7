require "rails_helper"

RSpec.describe "admin show page" do 
  describe "admin show page" do 

    # User Story 12
    it "has an approve button for applications" do 
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.", application_status: "Pending")

      shelter = Shelter.create!(foster_program: true, name: "Home Shelter", city: "Denver", rank: 1)

      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")

      pa1 = PetApplication.create!(application: application_1, pet: buddy)

      visit "/admin/applications/#{application_1.id}"
      expect(page).to have_content("Pending")
      expect(page).to have_content("Buddy Howly")
      click_button "Approve this Pet"
      expect(current_path).to eq("/admin/applications/#{application_1.id}")
      expect(page).to have_content("Application Status: Approved")
    end
  
    # User Story 13
    it "has a reject button for applications" do
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.", application_status: "Pending")
    
      shelter = Shelter.create!(foster_program: true, name: "Home Shelter", city: "Denver", rank: 1)
      
      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
      
      pa1 = PetApplication.create!(application: application_1, pet: buddy)
      
      visit "/admin/applications/#{application_1.id}"
      expect(page).to have_content("Pending")
      expect(page).to have_content("Buddy Howly")
      click_button "Reject this Pet"

      expect(current_path).to eq("/admin/applications/#{application_1.id}")
      expect(page).to have_content("Application Status: Rejected")
    end

  end
end