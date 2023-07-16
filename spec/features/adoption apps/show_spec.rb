require "rails_helper"

RSpec.describe "The Adoption Application", type: :feature do
  #user story 1
  describe "#show page" do
    before(:each) do
      test_data
    end
    it "displays an application on the show page" do

      visit "/adoption_apps/#{@adoption_app_1.id}"

      expect(page).to have_content(@adoption_app_1.name)
      expect(page).to have_content(@adoption_app_1.street_address)
      expect(page).to have_content(@adoption_app_1.city)
      expect(page).to have_content(@adoption_app_1.state)
      expect(page).to have_content(@adoption_app_1.zip_code)
      expect(page).to have_content(@adoption_app_1.description)
      expect(page).to have_content(@adoption_app_1.pet_names)
      expect(page).to have_content(@adoption_app_1.status)
    end

    it "Searches for pets" do

      visit "/adoption_apps/#{@adoption_app_1.id}"

      fill_in "Search", with: "Limb"
      click_button "Submit"

      expect(page).to have_content("Limb")
    end

    #user story 5
    it "displays a button called Adopt this Pet that adds the pet to the application" do

      visit "/adoption_apps/#{@adoption_app_2.id}"

      fill_in "Search", with: "Limb"
      click_button "Submit"

      expect(page).to have_content("Limb")
      
      click_button "Adopt this Pet"

      expect(page).to have_content("Pet Names: Limb")
    end
  end
end