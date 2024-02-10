require 'rails_helper'

RSpec.describe 'Application Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @shel_1 = Shelter.create!(name: "Dog's Home", city: "Gustine", foster_program: true, rank: 1)
      
      @pet_1 = @shel_1.pets.create!(name: "Cito", age: 4, breed: "Lab", adoptable: true)
      @pet_2 = @shel_1.pets.create!(name: "Charmander", age: 4, breed: "fire", adoptable: true)
      @pet_3 = @shel_1.pets.create!(name: "Char", age: 4, breed: "fire", adoptable: true)

      @app_1 = Application.create!(name: "Jack", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)
      @app_2 = Application.create!(name: "Jim", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)

      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    end

    # 1. Application Show Page
    it 'displays application and all pets with attributes' do
      # When I visit an applications show page
      visit "/applications/#{@app_1.id}"
      # Then I can see the following:
      # - Name of the Applicant
      # - Full Address of the Applicant including street address, city, state, and zip code
      # - Description of why the applicant says they'd be a good home for this pet(s)
      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.street_address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip)
      expect(page).to have_content(@app_1.description)
      expect(page).to have_content(@app_1.status)
      
      # - names of all pets that this application is for (all names of pets should be links to their show page)
      expect(page).to have_link(@pet_1.name)

      # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
      expect(page).to have_content(@app_1.status)
    end

    # 4. Searching for Pets for an Application
    it "can add pets to the application and search availible pets" do 
      # When I visit an application's show page
      visit "/applications/#{@app_1.id}"
      # And that application has not been submitted,
      expect(page).to_not have_content("Charmander")
      # Then I see a section on the page to "Add a Pet to this Application"
      expect(page).to have_content("Add a Pet to this Application")
      # In that section I see an input where I can search for Pets by name
      within '.pet-application' do
        expect(page).to have_content("Search for Pet:")
        # When I fill in this field with a Pet's name
        fill_in 'search', with: 'Charmander'
        # And I click submit,
        click_button("submit")
      end
      # Then I am taken back to the application show page
      expect(current_path).to eq("/applications/#{@app_1.id}")
      # And under the search bar I see any Pet whose name matches my search 
      within '.found-pets' do
        expect(page).to have_content(@pet_2.name)
      end
    end

    # 5. Add a Pet to an Application
    it "searched pets have an adopt this pet link.button" do
      # When I visit an application's show page
      visit "/applications/#{@app_1.id}"
      # And I search for a Pet by name
      within '.pet-application' do
        fill_in 'search', with: 'Charmander'
        click_button("submit")
      end
      # And I see the names Pets that match my search
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
        # Then next to each Pet's name I see a button to "Adopt this Pet"
        expect(page).to have_button("Adopt this Pet")
        # When I click one of these buttons
        click_button("Adopt this Pet")
      end
      # Then I am taken back to the application show page
      expect(current_path).to eq("/applications/#{@app_1.id}")
      # And I see the Pet I want to adopt listed on this application
      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
      end
    end

    # 6. Submit an Application
    it "can submit a application for review" do 
      # When I visit an application's show page
      visit "/applications/#{@app_1.id}"
      # And I have added one or more pets to the application
      expect(page).to have_content(@pet_1.name)

      within '.app-submission' do
        # Then I see a section to submit my application
        expect(page).to have_content("submit my application")
        # And in that section I see an input to enter why I would make a good owner for these pet(s)
        expect(page).to have_content("Why are you a good fit?")
        # When I fill in that input
        fill_in 'description', with: 'Plausable lie'
        # And I click a button to submit this application
        click_button("submit")
      end
      # Then I am taken back to the application's show page
      expect(current_path).to eq("/applications/#{@app_1.id}")
      # And I see an indicator that the application is "Pending"
      expect(page).to have_content("Status: Pending")
      # And I see all the pets that I want to adopt
      expect(page).to have_content(@pet_1.name)
      # And I do not see a section to add more pets to this application
      expect(page).to_not have_css(".pet-application")
    end

    # 7. No Pets on an Application
    it "has no pets on an application" do 
      # When I visit an application's show page
      visit "/applications/#{@app_2.id}"
      # And I have not added any pets to the application
      # Then I do not see a section to submit my application
      expect(page).to_not have_content(@pet_1.name)
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_css(".app-submission")
    end 
  
    # 8. Partial Matches for Pet Names
    it "allows partial name searches" do 
      # When I visit an application show page
      visit "/applications/#{@app_2.id}"
      # And I search for Pets by name
      within '.pet-application' do
        fill_in 'search', with: 'Ch'
        click_button("submit")
      end
      # Then I see any pet whose name PARTIALLY matches my search
      # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
      within '.found-pets' do
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_3.name)
      end
    end
    
    # 9. Case Insensitive Matches for Pet Names
    it "can search regardless of caps" do 
      # When I visit an application show page
      visit "/applications/#{@app_2.id}"
      # And I search for Pets by name
      within '.pet-application' do
        # Then my search is case insensitive
        # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
        fill_in 'search', with: 'cHaR'
        click_button("submit")
      end

      within '.found-pets' do
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_3.name)
      end
    end
  end 
end

