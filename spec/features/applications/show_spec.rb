require 'rails_helper'
RSpec.describe "the application show" do

  # User Story 1, Application Show Page
  it "shows the applications and all of their attributes" do
    application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
    
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.pet_names)
    expect(page).to have_content(application.status)
  end

  # User Story 4, Searching for Pets for an Application
  it 'Alows search for pet by name' do
    visit "/applications/#{application.id}"

    expect(page).to have_field("Enter a Pet's Name")
    expect(page).to have_button("Search By Name")
    
    fill_in "search", with: "Bru"
    click_button("Search")

    expect(page).to have_content(@bruno.name)
    expect(page).to have_content(@bruiser.name)
  end

  # User Story 5, Add a Pet to an Application
  it 'Allows for pet adoption' do
    visit "/applications/#{application.id}"
    fill_in "search", with: "Bru"
    click_button("Search")

    within(".adopt_#{@bruno.id}") do
      expect(page).to have_content "Adopt This Pet"
    end
    within(".adopt_#{@bruiser.id}") do
      expect(page).to have_content "Adopt This Pet"
    end

    within(".adopt_#{@bruno.id}") do
      click_button("Adopt This Pet")
    end

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(@bruno.name)
  end
end