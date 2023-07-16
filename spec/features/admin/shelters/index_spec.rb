require "rails_helper"

RSpec.describe "Admin shelters index" do
  describe "when I visit admin/shelter index" do
    it "displays all shelters listed in reverse alphabetical order by name" do
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

      visit "/admin/shelters"

      expect(shelter_2.name).to appear_before(shelter_3.name)
      expect(shelter_3.name).to appear_before(shelter_1.name)

    end
  end
end