require "rails_helper"

RSpec.describe "admin shelter index" do 
  describe "shows shelters in reverse alphabetical order" do 
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
  end
end