require "rails_helper"

RSpec.describe "the new applications form" do
  # User Story 3
  it "makes you complete all fields to submit a new application form" do
    visit "/applications/new"

    fill_in "name", with: "Bob"
    
    click_button "Save"

    expect(page).to have_content("You must fill in all fields to submit")

    fill_in "name", with: "Bob"
    fill_in "street_address", with: "1234 Bob's rd."
    fill_in "city", with: "Boulder"
    fill_in "state", with: "Colorado"
    fill_in "zip_code", with: "80302"
    fill_in "description", with: "I need a pet!"

    click_button "Save"
    application_id = Application.last.id
    expect(current_path).to eq "/applications/#{application_id}"

    expect(page).to have_content("Applicant Name: Bob")
    expect(page).to have_content("Street Address: 1234 Bob's rd.")
    expect(page).to have_content("City: Boulder")
    expect(page).to have_content("State: Colorado")
    expect(page).to have_content("Zip Code: 80302")
    expect(page).to have_content("Description: I need a pet!")
    expect(page).to have_content("Status: In Progress")
  end
end