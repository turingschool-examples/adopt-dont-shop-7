require 'rails_helper'

RSpec.describe "create application" do
    it "creates a application" do
        # As a visitor
        # When I visit the pet index page
        visit "/pets"
        # Then I see a link to "Start an Application"
        expect(page).to have_link("Start an Application")
        # When I click this link
        click_on("Start an Application")
        # Then I am taken to the new application page where I see a form
        expect(current_path).to eq("/applications/new")
        expect(find("form")).to have_content("Name")
        expect(find("form")).to have_content("Street address")
        expect(find("form")).to have_content("City")
        expect(find("form")).to have_content("State")
        expect(find("form")).to have_content("Zip code")
        expect(find("form")).to have_content("Description of why I would make a good home")
        # When I fill in this form with my:
        #   - Name
        fill_in "Name", with: "Lance"
        #   - Street Address
        fill_in "Street address", with: "92332 s jebel way" 
        #   - City
        fill_in "City", with: "Auroua"
        #   - State
        fill_in "State", with: "Colorado"
        #   - Zip Code
        fill_in "Zip code", with: "80015"
        #   - Description of why I would make a good home
        fill_in "Description", with: "I have windows"
        # And I click submit
        #save_and_open_page
        click_on("submit")
        
        # Then I am taken to the new application's show page
        application = Application.last
        expect(current_path).to eq("/applications/#{application.id}")

        # And I see my Name, address information, and description of why I would make a good home
        expect(page).to have_content(application.name)
        expect(page).to have_content(application.street_address)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip_code)
        expect(page).to have_content(application.description)
        # And I see an indicator that this application is "In Progress"
        expect(page).to have_content("In Progress")
    end
    
end