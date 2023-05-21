require "rails_helper"

RSpec.describe "admin index page" do
  before(:each) do
    test_data
  end

  describe "/admin/shelters" do
    it "All shelters listed in reverse alphabetical order by name" do
      visit "/admin/shelters"

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    end

    it "shows applications with pending applications in each shelter" do
      visit "/admin/shelters"

      # within "#pending_apps" do
        expect(page).to have_content("Pending Applications:")
        expect(page).to have_content("Pending Applications:")

      # end
    end
  end
end