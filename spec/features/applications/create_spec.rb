require "rails_helper"

RSpec.describe "application creation" do
  it "creates a new application" do    
  	visit "/applications/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Street address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip code")
    expect(page).to have_content("Description")  
  end

  describe "the application create" do
    context "if given valid data" do
      it "creates the application" do
        visit "/applications/new"

        fill_in "name", with: "Shaggy"
        fill_in "street_address", with: "1234 Bobs rd"
        fill_in "city", with: "Denver"
        fill_in "state", with: "Colorado"
        fill_in "zip_code", with: "80220"
        fill_in "description", with: "I want a dog!"

        click_button "Save"

        application_id = Application.last.id
        expect(current_path).to eq "/applications/#{application_id}"

        expect(page).to have_content("Name: Shaggy")
        expect(page).to have_content("Street Address: 1234 Bobs rd")
        expect(page).to have_content("City: Denver")
        expect(page).to have_content("State: Colorado")
        expect(page).to have_content("Zip Code: 80220")
        expect(page).to have_content("Description: I want a dog!")
        expect(page).to have_content("Status: In Progress")
      end
    end
  end
end