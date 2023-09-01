require "rails_helper"

RSpec.describe "Create Application" do
  it "is linked from the pet index page" do
    visit "/pets"

    # save_and_open_page
    
    click_link "Start an Application"

    expect(current_path).to eq("/applications/new")
  end

  it "has a for that includes these attributes" do
    visit "/applications/new"
    save_and_open_page
    expect(page).to have_content("New Application")
    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Street Address")
    expect(find("form")).to have_content("City")
    expect(find("form")).to have_content("State")
    expect(find("form")).to have_content("Zip Code")
    expect(find("form")).to have_content("Description of why I would make a good home")
  end
  
  context "given valid date" do
    it "creates an application and redirects to the show page" do
      visit "/applications/new"

      fill_in "Name", with: "Pavlov"
      fill_in "Street Address", with: "666 Burning Ave"
      fill_in "City", with: "HL"
      fill_in "Zip Code", with: "06660"
      fill_in "Description of why I would make a good home", with: "I want to move there salivatory glands to the outside of there face so I can measure the response to a bell"
      click_button "Submit"
      expect(current_path).to eq("/application/show")
      expect(page).to have_content("Pavlov")
      expect(page).to have_content("In Progress")

    end
  end



end