require "rails_helper"

RSpec.describe "Application creation" do
  describe "When I visit the pet index page I see a link to start an application" do
    it "has a link to start a new application" do
      visit "/pets"
      
      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      expect(page).to have_current_path("/applications/new")
    end
  end
  describe "I see a form for a new application" do
    it "renders the new form" do
      visit "/applications/new"
      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("New Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip code")
      expect(find("form")).to have_content("Description")
    end
    
    it "application will redirect to its show page upon successful creation" do
      visit "/applications/new"

      fill_in "Name", with: "Bob Johnson"
      fill_in "Street", with: "321 Memory Lane"
      fill_in "City", with: "Ogdenville"
      fill_in "State", with: "OR"
      fill_in "Zip code", with: "72534"
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
      fill_in "Zip code", with: "72534"
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

  describe "When I fail to fill in any of the form fields" do
    it "displays an error when a blank form is submitted" do
      visit "/applications/new"
      click_button "Submit"
      
      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("Error: Name can't be blank, Street can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank\nPets\nShelters\nVeterinarians\nVeterinary Offices\nNew Application\nName Street City State Zip code Description")
    end
    
    it "displays an error if any field is left blank" do
      visit "/applications/new"
      
      fill_in "Name", with: ""
      fill_in "Street", with: "321 Memory Lane"
      fill_in "City", with: "Ogdenville"
      fill_in "State", with: "OR"
      fill_in "Zip code", with: "72534"
      fill_in "Description", with: "I loves me some critters fo sure."
      click_button "Submit"

      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("Error: Name can't be blank")
    end
  end


end