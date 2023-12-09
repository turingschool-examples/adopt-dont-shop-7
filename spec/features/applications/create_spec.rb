require "rails_helper"

RSpec.describe "application creation" do

  describe "the application new" do
    it "renders the new form" do
      visit "/pets"
      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      expect(current_path).to eq("/applications/new")

      expect(page).to have_content("New Application")
      expect(page).to have_field(:name)
      expect(page).to have_field(:street_address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip_code)
      expect(page).to have_field(:description)
    end
  end

  describe "the application create form" do
    context "given valid data" do
      it "creates the application and redirects to the application's show page" do
       
        visit "applications/new"

        fill_in "name", with: "Dave"
        fill_in "street_address", with: "1924 North Coria Street"
        fill_in "city", with: "Brownsville"
        fill_in "state", with: "Texas"
        fill_in "zip_code", with: "78521"
        fill_in "description", with: "Because I say so!"
        click_button("Submit")

        application = Application.last
        
        expect(current_path).to eq("/applications/#{application.id}")

        expect(page).to have_content("Dave")
        expect(page).to have_content("1924 North Coria Street")
        expect(page).to have_content("Brownsville")
        expect(page).to have_content("Texas")
        expect(page).to have_content("78521")
        expect(page).to have_content("Because I say so!")
        expect(page).to have_content("In Progress")
        # expect(page).to have_content(application.application_status)
      end
    end

    context "given invalid data" do 
      it "it does not create the application, and alerts the user that required fields are missing. It redirects them back to the current page" do

        visit "/applications/new"

        fill_in "Name", with: " "

        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Please fill in all required fields")
      end
    end

    context "given invalid data" do
      it "re-renders the new form" do
        # 3. Starting an Application, Form not Completed

        # As a visitor
        # When I visit the new application page
        visit "/applications/new"
        # And I fail to fill in any of the form fields
        # And I click submit
        click_button("Submit")
        # Then I am taken back to the new applications page
        expect(current_path).to eq("/applications/new")
        # And I see a message that I must fill in those fields.
        expect(page).to have_content("Please fill in all required fields")
      end
    end
  end

end