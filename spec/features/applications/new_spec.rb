require "rails_helper"

RSpec.describe "new application page" do
  it "displays an application form for user to fill out" do
    visit "/applications/new"

    expect(page).to have_content("New Application")
    expect(page).to have_field("Name")
    expect(page).to have_field("Street Address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip Code")
    expect(page).to have_field("Description")
    expect(page).to have_button("Submit")
  end

  describe "new application" do
    it "creates new application" do
      visit "/applications/new"
      
      fill_in("Name", with: "Nick")
      fill_in("Street Address", with: "4530 32nd Street")
      fill_in("City", with: "San Diego")
      fill_in("State", with: "California")
      fill_in("Zip Code", with: 81503)
      fill_in("Description", with: "I like animals")
      click_button("Submit")
      
      expected_id = Application.last.id
      expect(current_path).to eq("/applications/#{expected_id}")
    end
    
    it "Requires an application to be filled out completely" do
      visit "/applications/new"
      
      fill_in("Name", with: "Javen")
      fill_in("Street Address", with: "28475 W. North St.")
      fill_in("City", with: "Lebanon")
      fill_in("State", with: "IN")
      fill_in("Zip Code", with: 13746)
      click_button("Submit")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: You must complete all fields")
    end
  end
end