require "rails_helper"

RSpec.describe "New Application" do
  it "link to new app on pets index" do
    #     Starting an Application
    # As a visitor
    # When I visit the pet index page
    visit "/pets"
    # Then I see a link to "Start an Application"
    expect(page).to have_link("Start an Application")
    # When I click this link
    click_link("Start an Application")
    # Then I am taken to the new application page where I see a form
    expect(current_path).to eq("/apps/new")
    # When I fill in this form with my:
    fill_in("Name", with: "Timmy")
    fill_in("Address", with: "123 Main St")
    fill_in("City", with: "Aurora, CO")
    fill_in("Zip", with: 80111)
    fill_in("Description", with: "I love dogs")
    # Name
    # Street Address
    # City
    # State
    # Zip Code
    # Description of why I would make a good home
    # And I click submit
    click_button("Submit")
    # Then I am taken to the new application's show page
    expect(current_path).to eq("/apps/#{App.last.id}")
    # And I see my Name, address information, and description of why I would make a good home
    expect(page).to have_content("Timmy")
    expect(page).to have_content("123 Main St")
    expect(page).to have_content("Aurora, CO")
    expect(page).to have_content("80111")
    expect(page).to have_content("I love dogs")
    # And I see an indicator that this application is "In Progress"
    expect(page).to have_content("In Progress")
  end

  it "redirects back to new application if the application isn't completed" do
    # Starting an Application, Form not Completed
    # As a visitor
    # When I visit the new application page
    visit "/apps/new"
    # And I fail to fill in any of the form fields
    fill_in("Name", with: "Timmy")
    fill_in("Address", with: "123 Main St")
    fill_in("City", with: "Aurora, CO")
    fill_in("Zip", with: 80111)
    # And I click submit
    click_button("Submit")
    # Then I am taken back to the new application's page
    expect(current_path).to eq(new_app_path)
    # And I see a message that I must fill in those fields.
    # expect(page).to have_content("Please fill out this field")
  end
end