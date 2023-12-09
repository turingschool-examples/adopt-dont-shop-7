require "rails_helper"

RSpec.describe "the application new" do
  it "has a form to create a new application" do

    visit "/applications/new"
    expect(page).to have_button("Submit Application")

    fill_in("name", with: "Fred Flintstone")
    fill_in("street_address", with: "123 Bedrock St")
    fill_in("city", with: "Rockville")
    fill_in("state", with: "Croatan")
    fill_in("zip_code", with: "12345")
    fill_in("description", with: "Good with dinos!")

    click_on("Submit Application")

    application = Application.last

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Fred Flintstone")
    expect(page).to have_content("In Progress")
  end
end
