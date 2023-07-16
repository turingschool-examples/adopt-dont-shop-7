require "rails_helper"

RSpec.describe "application show page" do

#[ ] done
# 1. Application Show Page
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application status (In progress, accepted, pending, or rejected)

  describe "when I visit the application show page" do
    it "displays the name of the applicant" do
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content(application_1.name)
    end
    
    it " displays full address of applicant" do
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zipcode)
    end
    
    it "description of why applicant is deserving of pet" do
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.description)
    end

    it "displays the names of all the pets on the application" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      application_1.pets << scrappy
      application_1.pets << scooby

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(scrappy.name)
      expect(page).to have_content(scooby.name)

      click_link("#{scrappy.name}")
      expect(page).to have_link("Scrappy", href: "/pets/#{scrappy.id}")
    end

    it "display the status of the application" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

      visit "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.status)
    end
  end

  describe "searching for pets for an application" do
    it "has a search bar to find a pet by name and see the pet returned back to me" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content("Add a Pet to this Application")

      fill_in "search", with: "Scooby"
      click_button "Search"

      expect(page).to have_content("Scooby")
      expect(page).to_not have_content("Scrappy")

      fill_in "search", with: "Scrappy"
      click_button "Search"
      
      expect(page).to have_content("Scrappy")
    end
    
    it "has a button 'Adopt this Pet' that when clicked takes user to application show and adds pet to application" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      
      visit "/applications/#{application_1.id}"
      
      
      fill_in "search", with: "Scrappy"
      click_button "Search"

      expect(page).to have_content(scrappy.name)
      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      expect(scrappy.name).to appear_before("Add a Pet to this Application")
    end
  end

# [ ] done

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
# And I do not see a section to add more pets to this 

  describe "submitting an application" do
    describe "when i visit an application show page" do
      it "has one or more pets on the application" do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

        visit "/applications/#{application_1.id}"

        fill_in "search", with: "Scrappy"
        click_button "Search"
        click_button "Adopt this Pet"

        expect(application_1.pets).to eq([scrappy])
      end

      it "displays a section to submit my application and fill out a description of why i would be a good pet owner" do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

        visit "/applications/#{application_1.id}"

        fill_in "search", with: "Scrappy"
        click_button "Search"
        click_button "Adopt this Pet"

        expect(page).to have_selector("form")
      end

      it " fills in form and clicks the submit button and redirects user to application show page where, there is no longer a field to add more pets and the application status changes to pending" do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")

        visit "/applications/#{application_1.id}"

        fill_in "search", with: "Scrappy"
        click_button "Search"
        click_button "Adopt this Pet"

        fill_in "application_description", with: "I love dogs"

        click_button "Submit"

        expect(page).to have_content("Pending")
        expect(page).to_not have_content("Add a Pet to this Application")
        expect(page).to_not have_button("Search")
      end
    end
  end

end