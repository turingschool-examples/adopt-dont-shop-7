require "rails_helper"

RSpec.describe "Applications show page" do

  describe "applications#show" do
    it "should display all the attributes of an application" do

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
        application_status: "Pending"
      })

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
    end
      
      # if 'in progress'
      # it "has a form input to add pets to the application" do

      # end

      it "has a button to add pets to the application" do

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
        application_status: "Pending"
      })

        visit "/applications/#{application.id}"

        expect(page).to have_button("Add Pet")
        # fill_in("Name", with: "Curtis")
        # form.click_button("Add Pet")
      end

      # it "each pet name is a link to its show page" do
      #   visit "/pets/#{@pet.id}"
      # end

      it "will return partial matches in a Pet name's search" do
        # 8. Partial Matches for Pet Names
        # As a visitor
        # When I visit an application show page
        visit "/applications/#{application.id}"
        # And I search for Pets by name
        # Then I see any pet whose name PARTIALLY matches my search
        # For example, if I search for "fluff", my search would 
        # match pets with names "fluffy", "fluff", and "mr. fluff"
      end
  end
end 

