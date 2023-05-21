require "rails_helper"

RSpec.describe "the application show page" do 

  # User Story 1 - All
  it "shows the application and all of its attributes" do

    #application
    application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.")

    #shelter
    shelter = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)

    #pet
    buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")

    #pet application
    pa1 = PetApplication.create!(application: application_1, pet: buddy)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content("Name: #{application_1.name}")
    expect(page).to have_content("Address: #{application_1.street_address}, #{application_1.city}, #{application_1.state}, #{application_1.zip_code}")
    expect(page).to have_content("Description: #{application_1.description}")
    expect(page).to have_content("Application Status: #{application_1.application_status}")
    expect(page).to have_link("Buddy Howly")
  end

    # User Story 4 
    it "shows the application and all of its attributes" do

      #application
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.")
  
      #shelter
      shelter = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)
  
      #pet
      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
  
      #pet application
      pa1 = PetApplication.create!(application: application_1, pet: buddy)
  
      visit "/applications/#{application_1.id}"
      fill_in :search, with: "Buddy Howly"
      click_button "Search"
      expect(page).to have_content("Buddy Howly")
      
      expect(page).to have_content("Name: #{application_1.name}")
      expect(page).to have_content("Address: #{application_1.street_address}, #{application_1.city}, #{application_1.state}, #{application_1.zip_code}")
      expect(page).to have_content("Description: #{application_1.description}")
      expect(page).to have_content("Application Status: #{application_1.application_status}")
      expect(page).to have_content("Add a Pet to this Application")
    end

    # User Story 5
    it "adds pets to the application" do 
        #application
        application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.")
  
        #shelter
        shelter = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)
    
        #pet
        buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
    
        visit "/applications/#{application_1.id}"
        fill_in :search, with: "Buddy Howly"
        click_button "Search"
        expect(page).to have_content("Buddy Howly")

        click_button "Adopt this Pet"

        expect(current_path).to eq("/applications/#{application_1.id}")
        expect(page).to have_content("#{buddy.name}")
        
    end

    # User Story 6
    it "submits the application" do 
      #application
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.")

      #shelter
      shelter = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)
  
      #pet
      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
  
      visit "/applications/#{application_1.id}"
      fill_in :search, with: "Buddy Howly"
      click_button "Search"
      expect(page).to have_content("Buddy Howly")

      click_button "Adopt this Pet"

      expect(current_path).to eq("/applications/#{application_1.id}")
      expect(page).to have_content("#{buddy.name}")
      
      expect(page).to have_content("Submit my Application")
      fill_in :pet_answer, with: "I really like this dog."

      click_button "Submit"
      expect(current_path).to eq("/applications/#{application_1.id}")
      #  NOTE FOR MJ: try in pry the below and remove before final submission!!!

      # expect(page).to have_content("Application Status: #{application_1.application_status}")
      expect(page).to have_content("Application Status: Pending")

      expect(page).to have_content("#{buddy.name}")
      expect(page).to_not have_content("Add a Pet to this Application")
      expect(page).to_not have_content("Why would you be a good owner for this pet(s)?")
    end

    # User Story 7
    it "does not submit the application without a selected pet" do 
      #application
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.")

      #shelter
      shelter = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)
  
      #pet
      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
  
      visit "/applications/#{application_1.id}"
      fill_in :search, with: "Buddy Howly"
      click_button "Search"
      expect(page).to have_content("Buddy Howly")

      expect(page).to_not have_content("Submit my Application")
      expect(page).to_not have_content("Why would you be a good owner for this pet(s)?")
    end

end

