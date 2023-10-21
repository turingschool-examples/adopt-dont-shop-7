require "rails_helper"

RSpec.describe "the applications show" do
  before(:each) do
    @timmy = App.create(name: "Timmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love dogs", status: "In Progress")
  end
  it 'lists an applicant with their details' do  
    #     [ ] done

    # Application Show Page
    # As a visitor
    # When I visit an applications show page
    visit "/apps/#{@timmy.id}"
    # Then I can see the following:

    # Name of the Applicant
    expect(page).to have_content("Timmy")
    # Full Address of the Applicant including street address, city, state, and zip code
    expect(page).to have_content("123 Main St")
    expect(page).to have_content("Aurora, CO")
    expect(page).to have_content("80111")
    # Description of why the applicant says they'd be a good home for this pet(s)
    expect(page).to have_content("I love dogs")
    # names of all pets that this application is for (all names of pets should be links to their show page)
    # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    expect(page).to have_content("In Progress")

    #user story 1
  end

  it 'can add pets to in progress applications' do
    #   [ ] done

    # Searching for Pets for an Application
    # As a visitor
    # When I visit an application's show page
    visit "/apps/#{@timmy.id}"
    # And that application has not been submitted,
    expect(@timmy.status).to eq("In Progress")
    # Then I see a section on the page to "Add a Pet to this Application"
    expect(page).to have_content("Add a Pet to this Application")
    # In that section I see an input where I can search for Pets by name
    expect(page).to have_field("Search pets by name here")
    # When I fill in this field with a Pet's name
    fill_in "Search pets by name here", with: "Lucille Bald"
    # And I click submit,
    click_button "Submit"
    # Then I am taken back to the application show page
    expect(page).to have_current_path("apps/#{@timmy.id}")
    # And under the search bar I see any Pet whose name matches my search
    expect(page).to have_content("Lucille Bald")
  end
end
