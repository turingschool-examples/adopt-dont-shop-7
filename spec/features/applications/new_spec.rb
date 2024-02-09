require 'rails_helper'

RSpec.describe 'new application form page' do
  # User Story 2
  # As a visitor
  # When I visit the pet index page
  # Then I see a link to "Start an Application"
  it "has a link to start an application" do
    visit "/pets"
    expect(page).to have_link("Start an Application", :href=>"/applications/new")
  end
  # When I click this link
  # Then I am taken to the new application page where I see a form
  it "can click this link and be taken to new application page" do
    visit '/pets'
    click_on "Start an Application"   
    expect(current_path).to eq("/applications/new")
  end

  it "will have a form to receive application info" do
    visit "/applications/new" 
    expect(page).to have_field("name")
    expect(page).to have_field("street_address")
    expect(page).to have_field("city")
    expect(page).to have_field("state")
    expect(page).to have_field("zip_code")
    expect(page).to have_field("endorsement")
    expect(page).to have_button("Submit Application")
  end
  # When I fill in this form with my:
  #   - Name
  #   - Street Address
  #   - City
  #   - State
  #   - Zip Code
  #   - Description of why I would make a good home
  # And I click submit
  # Then I am taken to the new application's show page
  it "can fill out the form and submit" do
    visit "/applications/new"
    fill_in "name", with:"Test Name"
    fill_in "street_address", with:"Test address"
    fill_in "city", with:"Nowhereville"
    fill_in "state", with:"Colorado"
    fill_in "zip_code", with:"00000"
    fill_in "endorsement", with:"I am the best pet owner"
    click_on "Submit"
    expect(current_path).not_to eq("/applications/new")   ###test for object later
  end
  # And I see my Name, address information, and description of why I would make a good home
  # And I see an indicator that this application is "In Progress"
  it "shows application information on its show page" do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    visit "/applications/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.endorsement)
    expect(page).to have_content("In Progress")
  end

# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.

  it 'will return the user to the new application page if the form is not fully filled out' do
    visit '/applications/new'
    fill_in "name", with:"Test Name"
    fill_in "street_address", with:"Test address"
    fill_in "city", with:"Nowhereville"
    fill_in "state", with:"Colorado"
    fill_in "zip_code", with:"00000"
    click_on "Submit"

    expect(page).to have_field("name")
    expect(page).to have_field("street_address")
    expect(page).to have_field("city")
    expect(page).to have_field("state")
    expect(page).to have_field("zip_code")
    expect(page).to have_field("endorsement")
    expect(page).to have_button("Submit Application")
  end

  it 'will show a message that it requires the user to fill in the blank fields' do
    visit '/applications/new'
    fill_in "name", with:"Test Name"
    fill_in "street_address", with:"Test address"
    fill_in "city", with:"Nowhereville"
    fill_in "state", with:"Colorado"
    fill_in "zip_code", with:"00000"
    click_on "Submit"

    within("#flash") do
      expect(page).to have_content("Please fill out all fields of the application before trying to submit")
    end
  end
end