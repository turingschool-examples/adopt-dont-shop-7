require 'rails_helper'

RSpec.describe "/applications/new", type: :feature do

  describe "New Application Creation" do
    # User Story 2 (part 2)
    it "can verify form elements" do
      visit "/applications/new"

      expect(page).to have_field("Name")
      expect(page).to have_field("Street Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Description")
      expect(page).to have_button("Submit")
    end

    it "can successfully fill out form and submit to application's show page" do
      visit "/applications/new"

      fill_in("Name", with: "John Smith")
      fill_in("Street Address", with: "123 Main Street")
      fill_in("City", with: "Wellington")
      fill_in("State", with: "Nebraska")
      fill_in("Zip", with: "48226")
      fill_in("Description", with: "great pet owner")
      click_button("Submit")

      expect(page).to have_current_path("/applications/#{Application.last.id}")
    end

    # User Story 3
    it "can prompt user to fill out form again when form is not fully completed" do
      visit "/applications/new"

      fill_in("Name", with: "Michael Jordan")
      fill_in("Street Address", with: "123 Space Jam")
      fill_in("City", with: "Chicago")
      fill_in("State", with: "Illinois")
      fill_in("Zip", with: "12345")
      # missing Description
      click_button("Submit")

      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("Error: ALL sections must be completed")

      fill_in("Name", with: "Michael Jordan")
      fill_in("Street Address", with: "123 Space Jam")
      fill_in("City", with: "Chicago")
      fill_in("State", with: "Illinois")
      fill_in("Zip", with: "12345")
      fill_in("Description", with: "loves the dogs")
      click_button("Submit")

      expect(page).to have_current_path("/applications/#{Application.last.id}")
    end
  end
end
