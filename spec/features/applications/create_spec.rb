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
      expect(find("form")).to have_content("Status")
    end


  end




end