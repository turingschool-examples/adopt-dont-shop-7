require "rails_helper"

RSpec.describe "New application" do 
  it "has a form for a new application" do
    visit "/applications/new"

    expect(page).to have_content("New Application")
    expect(page).to have_content("Name")
    expect(page).to have_content("Street Address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip Code")
    expect(page).to have_content("Description")
    expect(page).to have_button("Submit")
  end

  it "creates a new appplication given valid data" do 
    visit "/applications/new"

    fill_in "Name", with: "Noelle Hemphill"
    fill_in "Street Address", with: "2929 Rexing Rd"
    fill_in "City", with: "Fort Collins"
    fill_in "State", with: "CO"
    fill_in "Zip Code", with: "80521"
    fill_in "Description", with: "I'm literally the best"
    click_button "Submit"

    @new_app = Application.last
    expect(current_path).to eq("/applications/#{@new_app.id}") 

    expect(page).to have_content "Noelle Hemphill"
    expect(page).to have_content "2929 Rexing Rd"
    expect(page).to have_content "Fort Collins"
    expect(page).to have_content "CO"
    expect(page).to have_content "80521"
    expect(page).to have_content "I'm literally the best"
  end

  it "flashes an error message given invalid data" do 
    visit "/applications/new"

    fill_in "Street Address", with: "2929 Rexing Rd"
    fill_in "City", with: "Fort Collins"
    fill_in "State", with: "CO"
    fill_in "Zip Code", with: "80521"
    fill_in "Description", with: "I'm literally the best"
    click_button "Submit"

    expect(page).to have_content "Error: All fields must be filled in to submit"
  end
end