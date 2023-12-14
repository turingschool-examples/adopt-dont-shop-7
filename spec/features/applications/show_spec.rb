require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals", status: "In Progress")
    @application_with_no_pets = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals", status: "In Progress")

    @shelter = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create!(adoptable: true, age: 1, breed: "Tabby", name: "Cat")
    @hamster = @shelter.pets.create!(adoptable: true, age: 1, breed: "Tabby", name: "Hamster")

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @cat.id)
  end

  it "has application details" do
    # User Story 1
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.full_address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_link("#{@dog.name}")
    expect(page).to have_link("#{@cat.name}")
    expect(page).to have_content("In Progress")

    click_link("#{@dog.name}")

    expect(page.current_path).to eq("/pets/#{@dog.id}")

    visit "/applications/#{@application_1.id}"
    click_link("#{@cat.name}")

    expect(page.current_path).to eq("/pets/#{@cat.id}")
  end

  describe "searching for pets for an application" do
    it "has a search bar" do
      # User Story 4
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_content("Search for Pets by name:")
      expect(page).to have_button("Submit")
      expect(page).to have_no_content("Hamster")
      expect(page).to have_no_button("Adopt this pet")

      fill_in("Search for Pets by name:", with: "Hamster")
      click_button("Submit")

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_content("Search for Pets by name:")
      expect(page).to have_button("Submit")
      expect(page).to have_content("Hamster")
      expect(page).to have_button("Adopt this pet")

      expect(page.current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Hamster")
    end

    it "will let me add a pet to my application" do
      # User Story 5
      visit "/applications/#{@application_1.id}"

      expect(page).to have_no_content("Hamster")

      fill_in("Search for Pets by name:", with: "Hamster")
      click_button("Submit")
      expect(page).to have_button("Adopt this pet")
      click_button("Adopt this pet")

      expect(page.current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Hamster")
    end

    it "will show my application is 'pending' when I submit my application" do
      # User Story 4, 5, 6 - Integration Test
      visit "/applications/#{@application_1.id}"
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Add a Pet to this Application")

      fill_in "Search for Pets by name", with: "#{@dog.name}"
      click_button("Submit")

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@dog.name)

      click_button("Adopt this pet")

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@dog.name)

      fill_in "Why I would make a good owner:", with: "Worked with some more dinosaurs"
      expect(page).to have_button("Submit Application")

      click_button("Submit Application")
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Pending")
    end

    it "returns any pet whose name PARTIALLY matches my search" do
      # User Story 8
      visit "/applications/#{@application_with_no_pets.id}"

      expect(page).to have_no_content("Hamster")

      fill_in("Search for Pets by name:", with: "ham")
      click_button("Submit")

      expect(page).to have_content("Hamster")

      cat = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "fluffy")
      fluff = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "fluff")

      fill_in("Search for Pets by name:", with: "fluf")
      click_button("Submit")

      expect(page).to have_content("fluffy")
      expect(page).to have_content("fluff")
    end

    it "is case insensitive" do
      # User Story 9
      visit "/applications/#{@application_with_no_pets.id}"

      fluffy = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "FLUFF")
      dog = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "Mr. Fluff")

      fill_in("Search for Pets by name:", with: "fluff")
      click_button("Submit")

      expect(page).to have_content("FLUFF")
      expect(page).to have_content("Mr. Fluff")
    end
  end

  describe "Submit Application" do
    it "has a section to submit my application" do
      # User Story 6 - Unit Test
      visit "/applications/#{@application_1.id}"
      expect(page).to have_content("Dog")
      expect(page).to have_content("Cat")
      expect(page).to have_content("In Progress")

      within("#submit-application") do
        expect(page).to have_content "Why I would make a good owner"
        click_button "Submit Application"
      end

      fill_in("good_owner_comments", with: "We bonded when I visited the shelter")
      click_button("Submit Application")

      expect(current_path).to eq("/applications/#{@application_1.id}")

      expect(page).to have_no_content("In Progress")
      expect(page).to have_content("Pending")
      expect(page).to have_content("Pets Applied For:")
      expect(page).to have_content("Dog")
      expect(page).to have_content("Cat")

      expect(page).to have_no_content("Add a Pet to this Application")
      expect(page).to have_no_content("Search for Pets by name:")
      expect(page).to have_no_content("Submit Application")
    end

    it "will not show the submit section if I have not added any pets" do
      # User Story 7
      visit "/applications/#{@application_with_no_pets.id}"

      expect(page).to have_no_content("Why I would make a good owner")
      expect(page).to have_no_button("Submit Application")
    end
  end
end
