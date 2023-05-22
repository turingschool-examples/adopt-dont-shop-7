require "rails_helper"

RSpec.describe "Applications", type: :feature do
  describe "application#show" do
    before(:each) do
      @shelter1 = Shelter.create!(foster_program: true, name: "Bishop Animal Rescue", city: "Bishop", rank: 5)
      @pet1 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "Samoyed", name: "Fluffy")
      @pet2 = @shelter1.pets.create!(adoptable: true, age: 6, breed: "Husky", name: "Hubert")
      # ^ not applied by anyone
      @pet3 = @shelter1.pets.create!(adoptable: true, age: 8, breed: "Shiba Inu", name: "Shishi")

      @shelter2 = Shelter.create!(foster_program: true, name: "Chicago Animal Rescue", city: "Chicago", rank: 4)
      @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: "Lab", name: "Lally")
      @pet5 = @shelter2.pets.create!(adoptable: true, age: 10, breed: "Chihuahua", name: "Chewy")

      @shelter3 = Shelter.create!(foster_program: true, name: "Los Angeles Animal Rescue", city: "Los Angeles", rank: 3)
      @pet6 = @shelter3.pets.create!(adoptable: true, age: 5, breed: "Pitbull", name: "Bully")

      @app1 = Application.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled", status: "In Progress")
      @petapp1 = PetApplication.create!(application_id: @app1.id, pet_id: @pet1.id)
      @petapp2 = PetApplication.create!(application_id: @app1.id, pet_id: @pet4.id)

      @app2 = Application.create!(name: "Andy", street_address: "456 Downtown", city: "Anywhere", state: "HI", zip_code: "23456", description: "Anotha One -DJ Khaled", status: "Pending")
      @petapp3 = PetApplication.create!(application_id: @app2.id, pet_id: @pet1.id)
      @petapp4 = PetApplication.create!(application_id: @app2.id, pet_id: @pet3.id)
      @petapp5 = PetApplication.create!(application_id: @app2.id, pet_id: @pet6.id)

      @app3 = Application.create!(name: "Jeff", street_address: "567 Sideways", city: "Somewhere", state: "DE", zip_code: "34567", description: "We the best -DJ Khaled", status: "Rejected")
      @petapp6 = PetApplication.create!(application_id: @app3.id, pet_id: @pet5.id)
    end

    # 1. Application Show Page

    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

    it "shows a specific application" do
      visit "/applications/#{@app1.id}"

      expect(page).to have_content("Name: #{@app1.name}")
      expect(page).to have_content("Street Address: #{@app1.street_address}")
      expect(page).to have_content("City: #{@app1.city}")
      expect(page).to have_content("State: #{@app1.state}")
      expect(page).to have_content("Zip Code: #{@app1.zip_code}")
      expect(page).to have_content("Description: #{@app1.description}")
      expect(page).to have_content("Application Status: #{@app1.status}")

      expect(page).to have_link(@pet1.name, href: "/pets/#{@pet1.id}")
      expect(page).to have_link(@pet4.name, href: "/pets/#{@pet4.id}")
    end

    it "shows a specific application" do
      visit "/applications/#{@app2.id}"

      expect(page).to have_content("Name: #{@app2.name}")
      expect(page).to have_content("Street Address: #{@app2.street_address}")
      expect(page).to have_content("City: #{@app2.city}")
      expect(page).to have_content("State: #{@app2.state}")
      expect(page).to have_content("Zip Code: #{@app2.zip_code}")
      expect(page).to have_content("Description: #{@app2.description}")
      expect(page).to have_content("Application Status: #{@app2.status}")

      expect(page).to have_link(@pet1.name, href: "/pets/#{@pet1.id}")
      expect(page).to have_link(@pet3.name, href: "/pets/#{@pet3.id}")
      expect(page).to have_link(@pet6.name, href: "/pets/#{@pet6.id}")
    end

    it "shows a specific application" do
      visit "/applications/#{@app3.id}"

      expect(page).to have_content("Name: #{@app3.name}")
      expect(page).to have_content("Street Address: #{@app3.street_address}")
      expect(page).to have_content("City: #{@app3.city}")
      expect(page).to have_content("State: #{@app3.state}")
      expect(page).to have_content("Zip Code: #{@app3.zip_code}")
      expect(page).to have_content("Description: #{@app3.description}")
      expect(page).to have_content("Application Status: #{@app3.status}")

      expect(page).to have_link(@pet5.name, href: "/pets/#{@pet5.id}")
    end

    # 4. Searching for Pets for an Application

    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    it "can search to add pets for an application" do
      visit "/applications/#{@app1.id}"

      expect(page).to have_content("Add a Pet to this Application")

      within "#application-#{@app1.id}" do
        fill_in(:search, with: "Hubert")

        click_on("Search")

        expect(page).to have_content("Name: #{@pet2.name}")
        expect(page).to_not have_content("Name: #{@pet5.name}")
      end
    end

    # 5. Add a Pet to an Application

    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application
    it "can add pets to an application" do
      visit "/applications/#{@app1.id}/?search=#{@pet2.name}"

      within "#pets-#{@app1.id}" do
        expect(page).to_not have_content("Name: #{@pet2.name}")
      end

      visit "/applications/#{@app1.id}/?search=#{@pet2.name}"

      expect(page).to have_content("Add a Pet to this Application")

      click_button("Adopt this Pet")

      expect(current_path).to eq("/applications/#{@app1.id}")

      within "#pets-#{@app1.id}" do
        expect(page).to have_content("#{@pet2.name}")
      end
    end

    # 6. Submit an Application

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
    it "can add pets to an application" do
      visit "/applications/#{@app1.id}/?search=#{@pet2.name}"
      # There should be no option to submit application
      click_button("Adopt this Pet")
      expect(current_path).to eq("/applications/#{@app1.id}")
      save_and_open_page

      # There should an option to submit application
      within "#application-submit-#{@app1.id}" do
        fill_in(:description, with: "Because I love puppies")

        click_button("Submit Application")
        expect(current_path).to eq("/applications/#{@app1.id}")
      end

      # There should be no option to submit application
      expect(page).to have_content("Pending")

      within "#pets-#{@app1.id}" do
        expect(page).to have_content("#{@pet1.name}")
        expect(page).to have_content("#{@pet4.name}")
        expect(page).to have_content("#{@pet2.name}")
      end

      expect(page).to_not have_content("Adopt this Pet")
    end
  end
end