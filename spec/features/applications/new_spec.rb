require "rails_helper"

RSpec.describe "the application new" do
  it "shows application form" do
    visit "/applications/new"

    expect(page).to have_field("Name")
    expect(page).to have_field("Street Address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip Code")
    expect(page).to have_field("Description")
  end

  it "fills in the application" do
    visit "/applications/new"

    fill_in "Name", with: "Jerry springfield"
    fill_in "Street Address", with: "235 overthere ln"
    fill_in "City", with: "Las Vegas"
    fill_in "State", with: "Navada"
    fill_in "Zip Code", with: "44973"
    fill_in "Description", with: "I have windows"

    have_button "Submit"
    click_button "Submit"
    new_application = Application.last

    expect(current_path).to eq("/applications/#{new_application.id}")
  end

  it "displays created application" do
    visit "/applications/new"

    fill_in "Name", with: "Jerry springfield"
    fill_in "Street Address", with: "235 overthere ln"
    fill_in "City", with: "Las Vegas"
    fill_in "State", with: "Navada"
    fill_in "Zip Code", with: "44973"
    fill_in "Description", with: "I have windows"

    click_button "Submit"

    expect(page).to have_content("Jerry springfield")
    expect(page).to have_content("235 overthere ln")
    expect(page).to have_content("Las Vegas")
    expect(page).to have_content("Navada")
    expect(page).to have_content("44973")
    expect(page).to have_content("I have windows")
  end

  it "displays application status" do
    visit "/applications/new"

    fill_in "Name", with: "Jerry springfield"
    fill_in "Street Address", with: "235 overthere ln"
    fill_in "City", with: "Las Vegas"
    fill_in "State", with: "Navada"
    fill_in "Zip Code", with: "44973"
    fill_in "Description", with: "I have windows"

    click_button "Submit"

    expect(page).to have_content("In Progress")
  end

  it "displays an error message" do
    visit "/applications/new"

    fill_in "Description", with: ""

    click_button "Submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("error:Name can't be blank, Description can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank")
  end
end
