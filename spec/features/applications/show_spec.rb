require 'rails_helper'

RSpec.describe 'Applications Show Page', type: :feature do
  describe 'As a visitor' do
    before do
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
      @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
      @pet_3 = Pet.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Rocky", shelter_id: @shelter.id)
      @application_1 = Application.create!(name: "Selena", street_address: "123 Street", city: "City", state: "State", zip_code: "8888", adopting_reason: "Love for cats, no job", status:"Pending")
      @application_2 = Application.create!(name: "Laura", street_address: "58 Street", city: "City", state: "State", zip_code: "5555", adopting_reason: "Need company", status:"Rejected")
      @application_3 = Application.create!(name: "Isaac", street_address: "456 Street", city: "City", state: "State", zip_code: "8878", adopting_reason: "Lots of love to give", status:"Accepted")
      @application_4 = Application.create!(name: "Mark", street_address: "889 Folsom Ave", city: "Denver", state: "CO", zip_code: "80024", adopting_reason: "Lonely", status:"Pending")
      @application_pets_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @application_pets_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
      @application_pets_3 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_3.id)
    end

    #User Story 1 Application Show Page
    it "shows Applications Attributes" do
      # As a visitor
      # When I visit an applications show page
      visit "/applications/#{@application_1.id}"

      # Then I can see the following:
      # - Name of the Applicant
      expect(page).to have_content("#{@application_1.name}")
      
      # - Full Address of the Applicant including street address, city, state, and zip code
      expect(page).to have_content("#{@application_1.populate_address}")
      
      # - Description of why the applicant says they'd be a good home for this pet(s)
      expect(page).to have_content("#{@application_1.adopting_reason}")

      # - names of all pets that this application is for (all names of pets should be links to their show page)
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_link("Lucille Bald", href: "/pets/#{@pet_1.id}")
      # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
      expect(page).to have_content("#{@application_1.status}")
    end

    # User Story #4. Searching for Pets for an Application
    it "displays 'Add a Pet to this Application' when an application has not been submitted" do
      # As a visitor
      # When I visit an application's show page
      visit "/applications/#{@application_4.id}"
      # And that application has not been submitted,
      # Then I see a section on the page to "Add a Pet to this Application"
      within '.find_pet' do
        expect(page).to have_content("Add a Pet to this Application")
        # In that section I see an input where I can search for Pets by name
        # When I fill in this field with a Pet's name
        fill_in(:add_pet_name, with: "Rocky")
        # And I click submit,
        click_button("Submit")
      end
        # Then I am taken back to the application show page
      expect(current_path).to eq("/applications/#{@application_4.id}")
      within '.found_pet' do
        # And under the search bar I see any Pet whose name matches my search  
        within "#pet-#{@pet_3.id}" do
        expect(page).to have_content(@pet_3.name)
        end
      end
    end 

    # User Story #5 Add a Pet to an Application
    it "Displays button to adopt pet and lists it in the application" do
      # When I visit an application's show page
      visit "/applications/#{@application_4.id}"
      # And I search for a Pet by name
      within '.find_pet' do
      fill_in(:add_pet_name, with: "Rocky")
      click_button("Submit")
      end
      within'.found_pet' do
      # And I see the names Pets that match my search
        within "#pet-#{@pet_3.id}" do
          # Then next to each Pet's name I see a button to "Adopt this Pet"
          expect(page).to have_button("Adopt this Pet") 
          # When I click one of these buttons
          click_button("Adopt this Pet")
        end
      end
      # Then I am taken back to the application show page
      expect(current_path).to eq("/applications/#{@application_4.id}")
      within '.pets_in_application' do
        within "#pet-#{@pet_3.id}" do
          # And I see the Pet I want to adopt listed on this application
          expect(page).to have_content(@pet_3.name)
        end
      end
    end

    
    #User Story 6 # As a visitor
    # Submit an Application
    it 'displays a section to submit my application' do 
     
    # When I visit an application's show page
      visit "/applications/#{@application_4.id}"
    # And I have added one or more pets to the application

      ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_4.id)
      ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_4.id)
      ApplicationPet.create!(pet_id: @pet_3.id, application_id: @application_4.id)

    # Then I see a section to submit my application
      within '.submit_application' do
        expect(page).to have_content( "Submit My Application" )

      # And in that section I see an input to enter why I would make a good owner for these pet(s)
        expect(page).to have_field("Adopting reason")

      # When I fill in that input
        fill_in(:adopting_reason, with: "I love animals")

      # And I click a button to submit this application
        click_button("Submit")
      end
    # Then I am taken back to the application's show page
      expect(current_path).to eq("/applications/#{@application_4}")

    # And I see an indicator that the application is "Pending"
      expect(page).to have_content("Pending")

    # And I see all the pets that I want to adopt
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_content("#{@pet_3.name}")

    # And I do not see a section to add more pets to this application
      expect(page).to not_have_content("Add a Pet to this Application")
    end 

    #User story 7 As a visitor
    # No Pets on an Application
    it 'doesnt show a section to submit an application' do

    # When I visit an application's show page
      visit "/applications/#{@application_1}"
    # And I have not added any pets to the application
    # Then I do not see a section to submit my application
      expect(page).to_not have_button("Submit Application")
    end


    # User story 8 As a visitor
    # Partial Matches for Pet Names
    it 'displays any pet whose name PARTIALLY matches my search' do

    # When I visit an application show page
      visit "/applications/#{@application_1}"

    # And I search for Pets by name
    # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
      fill_in "pet_name_search", with: "fluff"
      click_button("Submit")

    # Then I see any pet whose name PARTIALLY matches my search
      expect(page).to have_content("fluffy")
      expect(page).to have_content("fluff")
      expect(page).to have_content("mr. fluff")
    end

    #Case Insensitive Matches for Pet Names
    # User story 9 bAs a visitor
    it 'makes search case insensitive' do 

    # When I visit an application show page
      visit "/applications/#{@application_1}"

    # And I search for Pets by name
    # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
      fill_in "pet_name_search", with: "fluff"
      click_button("Submit")

    # Then my search is case insensitive
      expect(page).to have_content("Fluffy")
      expect(page).to have_content("FLUFF")
      expect(page).to have_content("Mr. FlUfF")
    end
  end
end
