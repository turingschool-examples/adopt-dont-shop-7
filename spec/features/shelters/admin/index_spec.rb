require "rails_helper"

RSpec.describe "admin shelter index" do 
  describe "shows shelters index" do 
    it "shows shelters in reverse alphabetical order" do
      shelter1 = Shelter.create(name: "Public Shelter", city: "Irvine CA", foster_program: false, rank: 9)
      shelter2 = Shelter.create(name: "Safe Shelter", city: "Irvine CA", foster_program: false, rank: 8)
      shelter3 = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 7)
      
      visit "/admin/shelters"
      expect(shelter2.name).to appear_before(shelter1.name)
      expect(shelter2.name).to appear_before(shelter3.name)
      expect(shelter1.name).to appear_before(shelter3.name)
      
      expect(page).to have_content("Public Shelter")
      expect(page).to have_content("Safe Shelter")
      expect(page).to have_content("Mystery Building")
    end
    
    it "shows shelters with a pending application" do 
      shelter1 = Shelter.create(name: "Public Shelter", city: "Irvine CA", foster_program: false, rank: 9)
      shelter2 = Shelter.create(name: "Safe Shelter", city: "Irvine CA", foster_program: false, rank: 8)
      shelter3 = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 7)
      
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.", application_status: "Pending")
      
      shelter = Shelter.create!(foster_program: true, name: "Home Shelter", city: "Denver", rank: 1)
      shelter2 = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)
      
      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
      buddy2 = shelter2.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy")
      

      pa1 = PetApplication.create!(application: application_1, pet: buddy)
      pa2 = PetApplication.create!(application: application_1, pet: buddy2)

      
      visit "/admin/shelters"
      
      expect(page).to have_content("Shelters with Pending Applications:") 
      within("footer") do 
        expect(page).to have_content("Home Shelter")
        expect(page).to have_content("Public Shelter")
        expect(page).to_not have_content("Safe Shelter")
        expect(page).to_not have_content("Mystery Building")
      end
    end
  end
end