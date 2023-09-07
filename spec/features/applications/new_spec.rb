require "rails_helper"

RSpec.describe "new application form" do 
  it "US1: creates a new application" do 
    visit "/applications/new"

    expect(page).to have_field("Applicant Name")
    expect(page).to have_field("Street Address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip Code")
    expect(page).to have_field("Description")
    expect(page).to have_button("Submit")
  end

  context "US2: given valid data" do
    it "creates the pet and redirects to the shelter pets index" do
      visit "/applications/new"

      fill_in "Applicant Name", with: "Thomas Jefferson"
      fill_in "Street Address", with: "123 Main St."
      fill_in "City", with: "Boston"
      fill_in :state, with: "MA"
      fill_in :zip_code, with: "12345"
      fill_in "Description", with: "I'm on a fiver"
      click_button "Submit"

      @app1_id = Application.last.id
      expect(page).to have_current_path("/applications/#{@app1_id}")
      expect(page).to have_content("Thomas Jefferson")
      expect(page).to have_content("123 Main St.")
      expect(page).to have_content("Boston")
      expect(page).to have_content("MA")
      expect(page).to have_content("12345")
      expect(page).to have_content("I'm on a fiver")
      expect(page).to have_content("In Progress")
    end
  end 

  context "US3: given invalid data" do
    it "re-renders the new form" do
      visit "/applications/new"

      fill_in "Applicant Name", with: "Thomas Jefferson"
      fill_in "Street Address", with: "123 Main St."
      fill_in "City", with: "Boston"
      click_button "Submit"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: All fields must be filled in to submit")
    end
  end
end