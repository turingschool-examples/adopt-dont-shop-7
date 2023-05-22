require "rails_helper"

RSpec.describe "the new application page" do
  before :each do
    visit "/applications/new"
  end

  # describe "links" do
  # end

  describe "Body" do
    it "shows the title of the page" do
      expect(page).to have_content("New Application for Adoption")
    end

    it "shows application creation form" do
      expect(page).to have_content("Name")
      expect(page).to have_content("Street Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip Code")
      expect(page).to have_content("Why would you make a good home?")
    end

    it "can create a new application" do
      fill_in "Name", with: "Fredrich Longbottom"
      fill_in "Street Address", with: "1234 1st St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip Code", with: "80202"
      fill_in "Why would you make a good home?", with: "I love creatures."

      click_button "Submit"

      expect(current_path).to eq("/applications/#{Application.last.id}")

      new_application = Application.last

      expect(new_application.name).to eq("Fredrich Longbottom")
      expect(new_application.address).to eq("1234 1st St")
      expect(new_application.city).to eq("Denver")
      expect(new_application.state).to eq("CO")
      expect(new_application.zip).to eq("80202")
      expect(new_application.description_why).to eq("I love creatures.")
      expect(new_application.status).to eq("In Progress")

      expect(page).to have_content("Fredrich Longbottom")
      expect(page).to have_content("Application status: In Progress")
      expect(page).to have_content("Address: 1234 1st St, Denver, CO 80202")
      expect(page).to have_content("Description of why I would make a good home:")
      expect(page).to have_content("I love creatures.")
      expect(page).to have_content("Pets on this application:")
    end

    it "can generate errors if fields are incomplete" do
      fill_in "Name", with: "Fredrich Longbottom"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Why would you make a good home?", with: "I love creatures."

      click_button "Submit"

      expect(current_path).to eq("/applications/new")

      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("Zip can't be blank")
    end
  end
end
