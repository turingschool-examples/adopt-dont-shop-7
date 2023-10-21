require "rails_helper"

RSpec.describe "the applications show" do
  # before(:each) do

  # end
  it 'lists an applicant with their details' do
    timmy = App.create(name: "Timmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love dogs", status: "In Progress")
    
    #     [ ] done

    # Application Show Page
    # As a visitor
    # When I visit an applications show page
    visit "/apps/#{timmy.id}"
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

    # describe "searching for pets" do
    #   it "can search for pets whose name partially mathces search" do
        # 8. Partial Matches for Pet Names
        # 
        # As a visitor
        # When I visit an application show page
        # visit "/apps/#{app.id}")
        # expect(page).to have_content("search for pets by name:")
        # And I search for Pets by name

        # Then I see any pet whose name PARTIALLY matches my search
        # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"


    #   end
    # end

end