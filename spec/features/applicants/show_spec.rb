require 'rails_helper'

RSpec.describe "applicant show page", type: :feature do 
  before (:each) do 
    load_test_data
  end

  it "shows the name of the applicant and all of its attributes" do 
    visit "/applicants/#{@applicant_1.id}"

      expect(page).to have_content(@applicant_1.name)
      expect(page).to have_content(@applicant_1.street_address)
      expect(page).to have_content(@applicant_1.city)
      expect(page).to have_content(@applicant_1.state)
      expect(page).to have_content(@applicant_1.zipcode)
      expect(page).to have_content(@applicant_1.description)
      expect(page).to have_link("Drake")
      expect(page).to have_link("Bill")
  end

  it "allows user to search for a pets by name" do
    visit "/applicants/#{@applicant_1.id}"
    
    expect(page).to_not have_content("Yuka")

    fill_in(:name, with: "Yuka")
    click_button "Search"

    expect(page).to have_content("Yuka")
    # expect(page).to_not have_content("Bill")
  end
end