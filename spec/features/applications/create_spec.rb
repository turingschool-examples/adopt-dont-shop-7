require "rails_helper"

RSpec.describe "new application", type: :feature do
  it "has new application form" do
    visit "/applications/new"

    fill_in(:name, with: "Billy Bob")
    fill_in(:street_address, with: "5555 Main Street")
    fill_in(:city, with: "Seattle")
    fill_in(:state, with: "WA")
    fill_in(:zip_code, with: "98765")
    fill_in(:description, with: "Because I'm a movie star")
    
    click_button("Submit")
    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Name: #{Application.last.name}")
    expect(page).to have_content("Street Address: #{Application.last.street_address}")
    expect(page).to have_content("City: #{Application.last.city}")
    expect(page).to have_content("State: #{Application.last.state}")
    expect(page).to have_content("Zip Code: #{Application.last.zip_code}")
    expect(page).to have_content("Description: #{Application.last.description}")
    expect(page).to have_content("Application Status: #{Application.last.status}")
  end

  context "given invalid data" do
    it "re-renders the new form" do
      visit "/applications/new"
      click_button("Submit")

      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank")
    end
  end
end