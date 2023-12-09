require "rails_helper"

RSpec.describe "new application page" do

  before(:each) do 
    @application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")
  end

  it "has a form to create an application" do 
    visit "/applications/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Street Address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zipcode")
    expect(page).to have_content("Description")
    expect(page).to have_button("Submit")

    fill_in("name", with: "John")
    fill_in("street_address", with: "1234 ABC Lane")
    fill_in("city", with: "Turing")
    fill_in("state", with: "Backend")
    fill_in("zipcode", with: "54321")
    fill_in("description", with: "I love animals")
    click_button("Submit")

    # expect(current_path).to eq("/applications/#{@application.id}")
  end

  it "shows an error if all fields are not completed" do 
    visit "/applications/new"

    fill_in("street_address", with: "1234 ABC Lane")
    fill_in("city", with: "Turing")
    fill_in("state", with: "Backend")
    fill_in("zipcode", with: "54321")
    fill_in("description", with: "I love animals")
    click_button("Submit")

    expect(page).to have_content("Error: All fields are required.")
  end

end