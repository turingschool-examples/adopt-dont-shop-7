require "rails_helper"

RSpec.describe "applications#new" do
  describe "create a new application" do
    it "does not have any applicaitons prior" do
      visit "/applications/new"
      
      expect(Application.all).to eq([])
    end

    it "has a form with necessary fields to create and application" do
      visit "/applications/new"

      expect(page).to have_content("New Application")
      expect(page).to have_field(:name)
      expect(page).to have_field(:street_address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zipcode)
      expect(page).to have_field(:description)
      expect(page).to have_button("Submit")
    end

    it "accepts user input and creates a new application" do
      visit "/applications/new"
      fill_in(:name, with: "Jeff")
      fill_in(:street_address, with: "123 Fake St")
      fill_in(:city, with: "Coolsville")
      fill_in(:state, with: "BA")
      fill_in(:zipcode, with: "123456")
      fill_in(:description, with: "My name's rappin Jeff and I'm here to say")

      click_button("Submit")

      application = Application.last

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Jeff")
      expect(page).to have_content("123 Fake St")
      expect(page).to have_content( "Coolsville")
      expect(page).to have_content("BA")
      expect(page).to have_content("123456")
      expect(page).to have_content("My name's rappin Jeff and I'm here to say")
    end
  end
end