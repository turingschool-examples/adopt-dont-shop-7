require "rails_helper"

RSpec.describe "the applications index" do
  describe "app index" do
    it "lists all the applications with their attributes" do
      @application = Application.create!(name: "Jimmy John", street_address: "111 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")
      @application_2 = Application.create!(name: "Papa John", street_address: "222 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")

      visit "/applications"
      save_and_open_page
      expect(page).to have_content("#{@application.name}")
      expect(page).to have_content("#{@application_2.name}")
    end
  end
end
