require "rails_helper"

RSpec.describe "applications index page" do
  before(:each) do
    @application = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
  end

  describe "as a visitor" do
    describe "when I visit the welcome page" do
      it "has a link to the applications show page" do
        visit "/"
    
        expect(page).to have_link("Applications")
        click_link("Applications")
        expect(page).to have_current_path("/applications")
        click_link(@application.name)
        expect(page).to have_content("Mr. Ape")
      end
    end
  end
end