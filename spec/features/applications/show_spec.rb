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

      within "#search-pet-#{application.id}" do
        expect(page).to have_content("Add a pet to this application")
        expect(page).to have_field(:pet_name)
        fill_in(:pet_name, with: "Lobster")
        click_button("Search for Pets")
      end

      expect(page).to have_current_path("/applications/#{application.id}?pet_name=Lobster&commit=Search+for+Pets")
      
      # within "#adopt-pet-#{application.id}" do
        expect(page).to have_content("Lobster")
        expect(page).to have_button("Adopt this Pet")
        save_and_open_page
      # end
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
      expect(current_path).to be("/applications/#{application.id}")
      expect("Lucille Bald's").to appear_before("Search for Pets")
    end

    it "can submit an application" do
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

      # When I visit an application's show page
      visit "/applications/#{application.id}"

      # And  I have added one or more pets to the application
      fill_in(:pet_name, with: "Lucille Bald")
      fill_in(:pet_name, with: "Lobster")

      # Then I see a section to submit my application
      within "#submit-#{application.id}" do
        expect(page).to have_content("Submit Application")
        # And in that section I see an input to enter why I would make a good owner for these pet(s)
        expect(page).to have_field("Description")
        # When I fill in that input
        fill_in("Description", with: "Love pets and have a large yarde.")
        # And I click a button to submit this application
        click_button("Submit Application")
        # Then I am taken back to the application's show page
        expect(current_path).to be("/applications/#{application.id}")
        # And I see an indicator that the application is "Pending"
        expect(page).to have_content("Pending")
        # And I see all the pets that I want to adopt
        expect(page).to have_content("Lucille Bald, Lobster")
      end
        # And I do not see a section to add more pets to this app
        expect(page).to_not have_content("add-pet-#{application.id}")
    end
  end
end 

