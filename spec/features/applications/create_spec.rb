require "rails_helper"

RSpec.describe "Application creation" do
  describe "I see a form for a new application" do
    it "renders the new form" do
      visit "/applications/new"
      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("New Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip Code")
      expect(find("form")).to have_content("Description")
    end
    
    it "application will redirect to its show page upon successful creation" do
      visit "/applications/new"

      fill_in "Name", with: "Bob Johnson"
      fill_in "Street", with: "321 Memory Lane"
      fill_in "City", with: "Ogdenville"
      fill_in "State", with: "OR"
      fill_in "Zip Code", with: "72534"
      fill_in "Description", with: "I loves me some critters fo sure."
      click_button "Submit"

      expect(page).to have_current_path("/applications/#{Application.last.id}")
    end

    it "will save the information to the database" do
      visit "/applications/new"

      fill_in "Name", with: "Bob Johnson"
      fill_in "Street", with: "321 Memory Lane"
      fill_in "City", with: "Ogdenville"
      fill_in "State", with: "OR"
      fill_in "Zip Code", with: "72534"
      fill_in "Description", with: "I loves me some critters fo sure."
      click_button "Submit"

      bob = Application.last
      expect(bob.name).to eq("Bob Johnson")
      expect(bob.street).to eq("321 Memory Lane")
      expect(bob.city).to eq("Ogdenville")
      expect(bob.state).to eq("OR")
      expect(bob.zip_code).to eq("72534")
      expect(bob.description).to eq("I loves me some critters fo sure.")
      expect(bob.status).to eq("In Progress")
    end

  end


end