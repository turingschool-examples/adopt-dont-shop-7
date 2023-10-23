require "rails_helper"

RSpec.describe "the applications show" do
  before(:each) do
    @timmy = App.create(name: "Timmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love dogs", status: "In Progress")
    shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet1 = shelter1.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
    @timmy.pets << @pet1
    @pet2 = shelter1.pets.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
  end

  it 'lists an applicant with their details' do  
    #     [x] done

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
    expect(page).to have_content(@pet1.name)
    expect(page).to have_link("#{@pet1.name}", href: "/pets/#{@pet1.id}")
    click_link "#{@pet1.name}"
    expect(current_path).to eq("/pets/#{@pet1.id}")

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
    # Then I see a section on the page to "Search a pet"
    expect(page).to have_content("Search a pet")
    # In that section I see an input where I can search for Pets by name
    expect(page).to have_field("Search pets by name here")
    # When I fill in this field with a Pet's name
    fill_in "Search pets by name here", with: "Lobster"
    # And I click submit,
    click_button "Submit"
    # Then I am taken back to the application show page
    expect(current_path).to eq("/apps/#{@timmy.id}")
    
    # expect(page).to have_content("Add Lobster to this application")

    # click_link "Add Lobster to this application"
    # And under the search bar I see any Pet whose name matches my search
    expect(page).to have_content("Lobster")
  end

  describe "adopting pets" do
    it "can adopt pets" do

#       Add a Pet to an Application
        # As a visitor
        # When I visit an application's show page
        visit "/apps/#{@timmy.id}"
        # And I search for a Pet by name
        fill_in "Search pets by name here", with: "Lobster"
        # And I see the names Pets that match my search
        click_button "Submit"
        expect(page).to have_content("Lobster")
        # Then next to each Pet's name I see a button to "Adopt this Pet"
        expect(page).to have_button("Adopt #{@pet2.name}")
        # When I click one of these buttons
        click_button "Adopt #{@pet2.name}"
        # Then I am taken back to the application show page
        expect(current_path).to eq("/apps/#{@timmy.id}")
        # And I see the Pet I want to adopt listed on this application
        expect(page).to have_content("Lobster")
    end
  end

  describe "submitting applications" do
    it "Needs 1 or more pets to submit" do
      #user story 6
      #  Submit an Application
      # As a visitor
      # When I visit an application's show page
      visit "/apps/#{@timmy.id}"
      # And I have added one or more pets to the application
      expect(@timmy.pets.count > 0 ).to eq(true)
      # Then I see a section to submit my application
      expect(page).to have_content("Submit my application")
      # And in that section I see an input to enter why I would make a good owner for these pet(s)
      expect(page).to have_field("Why I would make a good owner for these pet(s)")
      # When I fill in that input
      fill_in "Why I would make a good owner for these pet(s)", with: "I love frogs"
      # And I click a button to submit this application
      click_button "Submit my application"
      # Then I am taken back to the application's show page
      expect(current_path).to eq("/apps/#{@timmy.id}")
      # And I see an indicator that the application is "Pending"
      expect(page).to have_content("Pending")
      # And I see all the pets that I want to adopt
      expect(page).to have_content(@pet1.name)
      # And I do not see a section to add more pets to this application
      expect(page).to_not have_content("Search a pet")
    end
  end
end
