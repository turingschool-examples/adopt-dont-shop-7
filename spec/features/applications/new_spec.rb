require "rails_helper"

RSpec.describe "the New application page", type: :feature do
  describe "As a visitor" do
    describe "when I visit the new application page" do
      it "I see a form with places for each attribute" do
        visit "/applications/new"

        fill_in "Name", with: "Spot"
        fill_in "Street Address", with: "123 Main st"
        fill_in "City", with: "Boulder"
        fill_in "State", with: "CO"
        fill_in "Zip Code", with: "12345"
        fill_in "Description of why I would make a good home", with: "I'm rich."
        click_button "Submit"

        expect(current_path).not_to eq("/application/new")
        # expect(current_path).to eq("/applications/#{application.id}")

        expect(page).to have_content("Spot")
        expect(page).to have_content("123 Main st, Boulder, CO 12345")
        expect(page).to have_content("I'm rich.")
        expect(page).to have_content("In Progress")
      end
    end
  end
end
