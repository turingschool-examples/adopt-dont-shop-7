require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals", status: 0)
    @application_with_no_pets = Application.create!(name: "No Pets", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals", status: 0)

    @shelter = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create!(adoptable: true, age: 1, breed: "Tabby", name: "Cat")
    @hamster = @shelter.pets.create!(adoptable: true, age: 1, breed: "Tabby", name: "Hamster")

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @cat.id)

    visit "/applications/#{@application_1.id}"
  end

  describe "User Story 1 - Applicatication Show" do
    it "has application details" do
      expect(page).to have_content("John's Application")
      expect(page).to have_content("Address: 1234 ABC Lane Turing, Backend 54321")
      expect(page).to have_content("Application Status: In Progress")
      expect(page).to have_content("Application Description: I love animals")
      expect(page).to have_link("#{@dog.name}")
      expect(page).to have_link("#{@cat.name}")
    end
  end

  describe "User Story 4 - Searching for Pets for an Application" do
    it "has a search bar" do
      expect(page).to have_content("In Progress")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field(:pet_name)

      fill_in(:pet_name, with: "Hamster")
      click_button("Submit")
      expect(page.current_path).to eq(show_applications_path(@application_1))
      expect(page).to have_content("Hamster")
    end
  end

  describe "User Story 4 - Sad Path" do
    it "displays an error if no pet is found with a matching name" do
      fill_in(:pet_name, with: "mamster")
      click_button("Submit")

      expect(page.current_path).to eq(show_applications_path(@application_1))
      expect(page).to have_content("No pet matching the name \"mamster\" found. Try another name:")
    end
  end

  describe "User Story 5 - Add a Pet to this Application" do
    it "will let me add a pet to my application" do
      expect(page).to have_no_content("Hamster")

      fill_in("Search for Pets by name:", with: "Hamster")
      click_button("Submit")
        within "#search-results" do
          expect(page).to have_content("Hamster")
          expect(page).to have_button("Adopt this pet")
        end

      click_button("Adopt this pet")
      expect(page.current_path).to eq("/applications/#{@application_1.id}")
      within "#pets-applied-for" do
        expect(page).to have_content("Hamster")
      end
    end
  end

  describe "User Story 6 - Submit Application" do
    it "will show my application is 'pending' when I submit my application" do
      expect(page).to have_content("Submit Application")
      expect(page).to have_content("Why #{@application_1.name} would make a good owner")

      fill_in :good_owner_comments, with: "Worked with some dinosaurs"
      expect(page).to have_button("Submit Application")

      click_button("Submit Application")
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("Dog")
      expect(page).to have_content("Cat")
      expect(page).to have_no_content("Add a Pet to this Application")
    end
  end

  describe "User Story 7 - No Pets on an Application" do
    it "has no section to submit my application" do
      visit "/applications/#{@application_with_no_pets.id}"

      expect(page).to have_no_content("Dog")
      expect(page).to have_no_content("Cat")
      expect(page).to have_no_content("Hamster")
      expect(page).to have_no_content("Submit Application")
    end
  end

  describe "User Story 8 - Partial Matches for Pet Names"
    it "returns any pet whose name PARTIALLY matches my search" do
      visit show_applications_path(@application_with_no_pets)

      expect(page).to have_no_content("Hamster")

      fill_in("Search for Pets by name:", with: "ham")
      click_button("Submit")

      expect(page).to have_content("Hamster")

      cat = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "fluffy")
      fluff = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "fluff")

      fill_in("Search for Pets by name:", with: "fluf")
      click_button("Submit")

      expect(page).to have_content(cat.name)
      expect(page).to have_content(fluff.name)
    end

  describe "User Story 9 - Case Insensitive Matches for Pet Names" do
    it "is case insensitive" do
      visit "/applications/#{@application_with_no_pets.id}"

      fluffy = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "FLUFF")
      dog = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "Mr. Fluff")

      fill_in("Search for Pets by name:", with: "fluf")
      click_button("Submit")

      expect(page).to have_content(fluffy.name)
      expect(page).to have_content(dog.name)
    end
  end
end
