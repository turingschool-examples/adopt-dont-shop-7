require 'rails_helper'

RSpec.describe "/applications/new", type: :feature do

  # User Story 2 (part 2)
  describe "New Application Creation" do
    it "can verify form elements" do
      expect(page).to have_current_path("/applications/new")
      expect(page).to have_field("Name")
      expect(page).to have_field("Street Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip Code")
      expect(page).to have_field("Description")
      expect(page).to have_button("Submit")
    end

    it "can fill out form and submit to applicantion's show page" do
      visit "/applications/new"

      fill_in("Name", with: "Kim Jong Un")
      fill_in("Street Address", with: "123 Peoples Square")
      fill_in("City", with: "Pyongyang")
      fill_in("State", with: "Florida")
      fill_in("Zip Code", with: "12345")
      fill_in("Description", with: "very good applicant")
      click_button("Submit")

      expect(page).to have_current_path("/applications/#{Application.last.id}")
    end
  end
end