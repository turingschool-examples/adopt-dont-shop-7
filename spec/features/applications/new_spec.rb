require "rails_helper"

RSpec.describe "Application New Page" do
  it "creates a new application" do

    visit "/applications/new"

    fill_in("name", with: "Barry Allahyar")
    fill_in("street_address", with: "13 Evergreen Road")
    fill_in("city", with: "Astoria")
    fill_in("state", with: "NY")
    fill_in("zipcode", with: "11102")
    fill_in("description", with: "I'm friendly and loving")
    
    click_button("Submit Application")
    

    # expect(current_path).to eq("/applications/")
    expect(current_path).to_not eq("/applications/new")
    
    expect(page).to have_content("Barry Allahyar")
  end
  it "redirects to a new application when all the blanks are not filled" do

    visit "/applications/new"

    fill_in("name", with: "Barry Allahyar")
    fill_in("street_address", with: "13 Evergreen Road")
    fill_in("zipcode", with: "11102")
    fill_in("description", with: "I'm friendly and loving")
    
    click_button("Submit Application")
    

    # expect(current_path).to eq("/applications/")
    expect(current_path).to eq("/applications/new")
    

  end
end