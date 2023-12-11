require "rails_helper"

RSpec.describe "application creation" do
  describe "the application new" do
    it "renders the new form" do

      visit "/applications/new"

      expect(page).to have_content("New Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street Address")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip Code")
      expect(find("form")).to have_content("Description")
    end
  end

  describe "the application create" do
    context "given valid data" do
      it "creates the application and redirects to the created application show" do
        visit "/applications/new"

        fill_in "Name", with: "Bumblebee"
        fill_in "Street Address", with: "123 Calle del Valle"
        fill_in "City", with: "Puerto Vallarta"
        fill_in "State", with: "Jalisco"
        fill_in "Zip Code", with: 48290
        fill_in "Description", with: "I like animals"
        click_button "Save"

        expect(page).to have_content("Bumblebee")
        expect(page).to have_content("Puerto Vallarta")
      end
    end

    context "given invalid data" do
      it "re-renders the application new form" do
        visit "/applications/new"
        click_button "Save"

        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Zip code is not a number, Zip code is the wrong length (should be 5 characters), Description can't be blank")
      end
    end
  end
end