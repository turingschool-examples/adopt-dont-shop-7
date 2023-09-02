require 'rails_helper'

RSpec.describe "the applications new page" do
  it "has a form to fill in for a new application" do
    visit "/applications/new"

    expect(page).to have_field("name")
    expect(page).to have_field("addr")
    expect(page).to have_field("city")
    expect(page).to have_field("state")
    expect(page).to have_field("zip")
    expect(page).to have_field("description")
    expect(page).to have_button("Submit")
  end

  it "creates a new application and redirects to the application show page when submitted" do
    visit "/applications/new"

    fill_in("name", with: "Tyler Blackmon")
    fill_in("addr", with: "1234 Street Address")
    fill_in("city", with: "Colorado Springs")
    fill_in("state", with: "CO")
    fill_in("zip", with: "80922")
    fill_in("description", with: "I have a really good description so you should let me have a pet!")
    click_button("Submit")

    new_app = Application.all.first

    expect(page).to have_current_path("/applications/#{new_app.id}")
    expect(page).to have_content("Tyler Blackmon")
    expect(page).to have_content("1234 Street Address, Colorado Springs, CO, 80922")
    expect(page).to have_content("I have a really good description so you should let me have a pet!")
    expect(page).to have_content("In Progress")
  end

  it "sends an error message if any form fields are not filled in" do
    visit "/applications/new"
    fill_in("name", with: "Tyler Blackmon")
    fill_in("addr", with: "1234 Street Address")
    fill_in("city", with: "Colorado Springs")
    fill_in("state", with: "CO")
    fill_in("zip", with: "80922")
    click_button("Submit")

    expect(page).to have_content("Please fill in all fields.")
  end
end