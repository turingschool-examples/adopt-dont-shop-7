require "rails_helper"

RSpec.describe "As a visitor" do
  describe "When I visit the admin shelter index" do
    it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "Littleton shelter", city: "Littleton, CO", foster_program: false, rank: 9)

      visit "/admin/shelters"

      expect(page).to have_content("Littleton shelter")
      expect(page).to have_content("Aurora shelter")
      expect(@shelter_2.name).to appear_before(@shelter_1.name) 
    end
  end

  describe "When I visit the admin shelter index ('/admin/shelters')" do
    it "Then I see a section for 'Shelters with Pending Applications' And in this section I see the name of every shelter that has a pending application" do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "Littleton shelter", city: "Littleton, CO", foster_program: false, rank: 9)

      visit "/admin/shelters"

      expect(page).to have_content("Shelters with pending applications")
    end
  end
end