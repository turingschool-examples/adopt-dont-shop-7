require "rails_helper"

RSpec.describe "application creation" do
  describe "the application new" do

    # User Story 2 - Part (2/3)
    it "renders the new form" do
      visit "/applications/new"

      expect(page).to have_content("New Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street Address")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip Code")
      expect(find("form")).to have_content("Description")
      expect(page).to have_button("Submit")
    end
  end

  describe "the application create" do
    context "given valid data" do
      # User Story 2 - Part (3/3)
      it "creates the application" do

        visit "/applications/new"

        fill_in "Name", with: "John Doe"
        fill_in "Street Address", with: "123 Sesame St"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zip Code", with: "80202"
        fill_in "Description", with: "I have lots of money."
        click_button "Submit"
        
        new_application = Application.all.last
        
        expect(page).to have_current_path("/applications/#{new_application.id}")
        expect(page).to have_content("Name: #{new_application.name}")
        expect(page).to have_content("Name: John Doe")
        
        expect(page).to have_content("Address: #{new_application.street_address}, #{new_application.city}, #{new_application.state}, #{new_application.zip_code}")
        expect(page).to have_content("Address: 123 Sesame St, Denver, CO, 80202")
        
        expect(page).to have_content("Description: #{new_application.description}")
        expect(page).to have_content("Description: I have lots of money.")
        expect(page).to have_content("Application Status: #{new_application.application_status}")
        expect(page).to have_content("Application Status: In Progress")
        
      end
    end
    
    describe "given invalid data" do
      it "re-renders the new form" do

        visit "/applications/new"
        fill_in "Name", with: "John Doe"
        click_button "Submit"
        
        expect(page).to have_current_path("/applications/new")

        within ("div") do
          expect(page).to have_content("Error: Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank")
        end
      end
    end
  end
end
