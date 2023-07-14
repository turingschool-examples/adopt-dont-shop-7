require "rails_helper"

RSpec.describe "application creation" do
  before(:each) do
    @mr_ape = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    @penny_lane = Application.create!(name: "Penny Lane", street: "555 McCartney", city: "Hollywood", state: "California", zip: "90210", description: "Strawberry Fields Forever", status: "In Progress")
  end

  describe "new application" do
    it "renders the new form" do
      visit "/pets"

      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      expect(page).to have_current_path("/applications/new")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip")
      expect(find("form")).to have_content("Description")
    end

    it "creates a new application in the database" do
      visit "/applications/new"

      fill_in "Name", with: "Bob"
      fill_in "Street", with: "123 Fake St."
      fill_in "City", with: "Ogdenville"
      fill_in "State", with: "UT"
      fill_in "Zip", with: "12345"
      fill_in "Description", with: "I love dogs"
      click_on "Submit"

      bob = Application.last
      expect(bob.name).to eq("Bob")
      expect(bob.street).to eq("123 Fake St.")
      expect(bob.city).to eq("Ogdenville")
      expect(bob.state).to eq("UT")
      expect(bob.zip).to eq("12345")
      expect(bob.description).to eq("I love dogs")
      expect(bob.status).to eq("In Progress")
    end

  end




end