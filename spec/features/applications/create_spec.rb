require "rails_helper"

RSpec.describe "application create" do

  it "renders the new form" do

    visit "/applications/new"

    # save_and_open_page

    expect(page).to have_content("New Application")
    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Street Address")
    expect(find("form")).to have_content("City")
    expect(find("form")).to have_content("State")
    expect(find("form")).to have_content("Zip Code")
    expect(find("form")).to have_content("Description")
  end


  it "creates the application and redirects to the created application show" do
    visit "/applications/new"

    fill_in "Name", with: "Bumblebee"
    fill_in "Street Address", with: "123 Calle del Valle"
    fill_in "City", with: "Puerto Vallarta"
    fill_in "State", with: "Jalisco"
    fill_in "Zip Code", with: 48290
    fill_in "Description", with: "I like animals"
    click_button "Save"
    save_and_open_page
    expect(page).to have_content("Bumblebee")
    expect(page).to have_content("Puerto Vallarta")
  end

end
