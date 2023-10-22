require "rails_helper"

RSpec.describe "application creation" do

  describe "the application new" do
    it "renders the new form" do
      visit "/pets"
      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      expect(current_path).to eq("/applications/new")

      expect(page).to have_content("New Application")
      expect(page).to have_field("Name")
      expect(page).to have_field("Street Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip Code")
      expect(page).to have_field("Description")
    end
  end

  describe "the application create form" do
    context "given valid data" do
      it "creates the application and redirects to the application's show page" do
        
        visit "applications/new"

        fill_in "Name", with: "Dave"
        fill_in "Street Address", with: "1924 North Coria Street"
        fill_in "City", with: "Brownsville"
        fill_in "State", with: "Texas"
        fill_in "Zip Code", with: "78521"
        fill_in "Description", with: "Because I say so!"
        click_button("Submit")
        application = Application.last
        expect(current_path).to eq("applications/#{application.id}")

        pending "Show page must be completed prior to testing"
        expect(page).to have_content("Dave")
        expect(page).to have_content("1924 North Coria Street")
        expect(page).to have_content("Brownsville")
        expect(page).to have_content("Texas")
        expect(page).to have_content("78521")
        expect(page).to have_content("Because I say so!")
        expect(page).to have_content("In Progress")
      end
    end
  end
end