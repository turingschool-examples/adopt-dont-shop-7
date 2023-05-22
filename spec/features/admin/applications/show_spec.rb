require "rails_helper"

RSpec.describe "Admin Application Show Page", type: :feature do
  before(:each) do
    admin_test_data
  end

  describe "Approving a Pet for an Application" do
    describe "I see every pet that the app is for and buttons to approve each pet" do
      it "can approve a pet for a specific application" do
        visit("admin/applications/#{@application_1.id}")
        expect(page).to have_content("Pending Pets:")
        expect(page).to have_content("#{@pet_2.name}")
        expect(page).to have_content("#{@pet_4.name}")

        expect(page).to have_button("Approve #{@pet_2.name}")
        expect(page).to have_button("Approve #{@pet_4.name}")
      end
    end
  end
end