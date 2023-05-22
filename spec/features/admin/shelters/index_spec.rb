require "rails_helper"

RSpec.describe "admin index page" do
  describe "/admin/shelters" do
    it "All shelters listed in reverse alphabetical order by name" do
      test_data
      visit "/admin/shelters"

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    end

    it "shows applications with pending applications in each shelter" do
      admin_test_data
      visit "/admin/shelters"

      within "#pending_apps" do
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content("Aurora shelter")
        expect(page).to have_content("RGV animal shelter")
        expect(page).to_not have_content("Fancy pets of Colorado")
      end
    end
  end
end