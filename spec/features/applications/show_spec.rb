require "rails_helper"

RSpec.describe "applications show page" do
  before(:each) do
    @app1 = Application.create!(
      name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
      description: "Good home for good boy", status: "In Progress"
    )
    @app2 = Application.create!(
      name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
      description: "Good home for good boy", status: "In Progress"
    )
    @app_accepted = Application.create!(
      name: "Robby", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
      description: "Good home for good boy", status: "Accepted"
    )
    @app_no_pets = Application.create!(
      name: "Bobby", address: "1111 Longhorn", city: "Dela Mar", state: "NY", zip: "11101",
      description: "Good home for good boy", status: "In Progress"
    )
    @s1 = Shelter.create!(foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2)
    @p1 = Pet.create!(name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id)
    @p2 = Pet.create!(name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id)
    PetApplication.create!(application: @app1, pet: @p2)
    PetApplication.create!(application: @app2, pet: @p1)
  end

  it "shows the attributes of the application" do
    # US 1
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

    visit "/applications/#{@app1.id}"

    expect(page).to have_content @app1.name
    expect(page).to have_content @app1.full_address
    expect(page).to have_content @app1.description
    expect(page).to have_content @app1.pet_names.join(" | ")
    expect(page).to have_content @app1.status
  end

  describe "unsubmitted applications" do
    # US 4
    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    it "shows Add a Pet section" do
      visit "/applications/#{@app2.id}"

      expect(page).to have_content "Add a Pet"

      visit "/applications/#{@app_accepted.id}"

      expect(page).to_not have_content "Add a Pet"
    end

    it "shows a search bar" do  # US 4.1
      visit "/applications/#{@app2.id}"

      fill_in :q, with: "Buster"
      click_button "Search"

      expect(page).to have_content "Search Results:\nBuster"
    end

    # US 5
    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application
    it "shows a button inline with pet to adopt pet after search match" do
      visit "/applications/#{@app_no_pets.id}"

      fill_in :q, with: "Buster"
      click_button "Search"

      within("#pet-#{@p1.id}") do
        click_button "Adopt"
      end

      expect(page).to have_content "Pets: Buster"
    end

    # US 6
    # As a visitor
    # When I visit an application's show page
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    # And I click a button to submit this application
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
    it "can submit application with a reason and changes the application status to 'pending' displaying all added pets" do
      visit "/applications/#{@app1.id}"

      fill_in :q, with: "Buster"
      click_button "Search"

      within("#pet-#{@p1.id}") do
        click_button "Adopt"
      end

      expect(page).to have_content("Pets: Buster | Kyo")

      fill_in :reason_for_good_owner, with: "A loving family."
      click_button "Submit Application"
      expect(current_path).to eq("/applications/#{@app1.id}")
      expect(page).to have_content("Application Status: Pending")
      expect(page).to have_content("Pets: Buster | Kyo")
      expect(page).to_not have_content("Add a Pet")
    end

    # US7
    # As a visitor
    # When I visit an application's show page
    # And I have not added any pets to the application
    # Then I do not see a section to submit my application
    it "does not display a section to submit application if a pet has not been added" do
      visit "/applications/#{@app_no_pets.id}"

      expect(@app_no_pets.pet_names).to eq([])

      expect(page).to_not have_content("Submit Application")
    end
  end
end
