require "rails_helper"

RSpec.describe "Applications show page" do
  describe "an In Progress application" do
    it "should display the contact information of the user" do

      application = Application.create!({

        name: "Joe Smith", 
        street_address: "2323 Wysteria Ln.",
        city: "Littleton",
        state: "CO",
        zip_code: "89321",
        description: "Love pets; live on farm",
        application_status: "In Progress"
      })

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.application_status)
    end

    it "has a section to search for pets by name" do
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

      application = Application.create!({
        name: "Joe Smith", 
        street_address: "2323 Wysteria Ln.",
        city: "Littleton",
        state: "CO",
        zip_code: "89321",
        description: "Love pets; live on farm",
        application_status: "In Progress"
      })

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a pet to this application")
      expect(page).to have_field(:pet_name)
      fill_in(:pet_name, with: "Lobster")
      click_button("Search for Pets")


      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Lobster")
      expect(page).to have_button("Adopt this Pet")
    end

    it "can add a pet to an application" do
      application = Application.create!({
        name: "Joe Smith", 
        street_address: "2323 Wysteria Ln.",
        city: "Littleton",
        state: "CO",
        zip_code: "89321",
        description: "Love pets; live on farm",
        application_status: "In Progress"
      })

      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

      visit "/applications/#{application.id}"

      fill_in(:pet_name, with: "Lucille Bald")
      click_button("Search for Pets")
      expect("Lucille Bald").to_not appear_before("Search for Pets")
      expect(page).to have_button("Adopt this Pet")
      click_button("Adopt this Pet")
      expect(current_path).to eq("/applications/#{application.id}")
      expect("Lucille Bald").to appear_before("Search for Pets")
    end

    it "can submit an application with one or more pets" do
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

      application = Application.create!({
        name: "Joe Smith", 
        street_address: "2323 Wysteria Ln.",
        city: "Littleton",
        state: "CO",
        zip_code: "89321",
        description: "Love pets; live on farm",
        application_status: "In Progress"
      })

      application.pets << pet_1

      visit "/applications/#{application.id}"

      expect(page).to have_button("Submit Application")

      expect(page).to have_field(:why_good_owner)

      fill_in("Why would you make a good owner?", with: "Love pets and have a large yard.")

      click_button("Submit Application")

      expect(current_path).to eq("/applications/#{application.id}")

      expect(page).to_not have_content("In Progress")
      expect(page).to have_content("Pending")
      expect(page).to have_content("Lucille Bald")

      expect(page).not_to have_content("Search for Pets")
    end

    it "won't display a submit section until a pet has been added to the application" do
      application = Application.create!({
        name: "Joe Smith", 
        street_address: "2323 Wysteria Ln.",
        city: "Littleton",
        state: "CO",
        zip_code: "89321",
        description: "Love pets; live on farm",
        application_status: "In Progress"
       })

      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)

      visit "/applications/#{application.id}"
      
      expect(page).not_to have_css(".submit-section")

      application.pets << pet_1

      visit "/applications/#{application.id}"
      
      expect(page).to have_css(".submit-section")
      
    it "will return partial matches in a Pet name's search" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
      application = Application.create!(name: 'Taylor', street_address: '123 Side St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'In Progress')
      shelter.pets.create!(name: 'fluffy', age: 1, breed: 'Golden', adoptable: true) 
      shelter.pets.create!(name: 'fluff', age: 1, breed: 'Golden', adoptable: true) 
      shelter.pets.create!(name: 'mr. fluff', age: 1, breed: 'Golden', adoptable: true) 


      # 8. Partial Matches for Pet Names
      # As a visitor
      # When I visit an application show page
      visit "/applications/#{application.id}"
      # And I search for Pets by name
      fill_in 'Search', with: "fluff"
      click_on("Search")

      # Then I see any pet whose name PARTIALLY matches my search
      # For example, if I search for "fluff", my search would 
      # match pets with names "fluffy", "fluff", and "mr. fluff"


      expect(page).to have_content("fluffy")
      expect(page).to have_content("fluff")
      expect(page).to have_content("mr. fluff")
    end

    it "return case insensitive partial matches in a Pet name's search" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
      application = Application.create!(name: 'Taylor', street_address: '123 Side St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'In Progress')
      shelter.pets.create!(name: 'Fluffy', age: 1, breed: 'Golden', adoptable: true) 
      shelter.pets.create!(name: 'FLUFF', age: 1, breed: 'Golden', adoptable: true) 
      shelter.pets.create!(name: 'Mr. FlUfF', age: 1, breed: 'Golden', adoptable: true) 

      # 9. Case Insensitive Matches for Pet Names

      # As a visitor
      # When I visit an application show page
      visit "/applications/#{application.id}"
      # And I search for Pets by name
      fill_in 'Search', with: "fluff"
      click_on("Search")
      # Then my search is case insensitive
      # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
      

      expect(page).to have_content("Fluffy")
      expect(page).to have_content("FLUFF")
      expect(page).to have_content("Mr. FlUfF")
    end
  end
end 

