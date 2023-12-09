require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals", status: "In Progress")
    @application_with_no_pets = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals", status: "In Progress")

    @shelter = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "Cat")
    @hamster = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "Hamster")

    @application_pet_1 = ApplicationPet.create(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create(application_id: @application_1.id, pet_id: @cat.id)
  end

  it "has application details" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.full_address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_link("#{@dog.name}")
    expect(page).to have_link("#{@cat.name}")
    expect(page).to have_content(@application_1.status)

    click_link("#{@dog.name}")

    expect(page.current_path).to eq("/pets/#{@dog.id}")

    visit "/applications/#{@application_1.id}"
    click_link("#{@cat.name}")

    expect(page.current_path).to eq("/pets/#{@cat.id}")
  end

  describe "searching for pets for an application" do
    it "has a search bar" do

      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_content("Search for Pets by name:")
      expect(page).to have_no_content("Hamster")
      expect(page).to have_button("Submit")

      fill_in("Search for Pets by name:", with: "Hamster")
      click_button("Submit")

      expect(page.current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Hamster")
    end

    it "will let me add a pet to my application" do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("Hamster")

      fill_in("Search for Pets by name:", with: "Hamster")
      click_button("Submit")

      expect(page).to have_button("Adopt this pet")

      click_button("Adopt this pet")

      expect(page.current_path).to eq("/applications/#{@application_1.id}")
      # expect(page).to have_content("Hamster")
    end
  end

  it "has a section to submit my application" do
    visit "/applications/#{@application_1.id}"
    # Add one or more pets to the application (waiting on user story 5)

    expect(page).to have_content("Why I would make a good owner")
    expect(page).to have_button("Submit Application")

    fill_in("good_owner_comments", with: "We bonded when I visited the shelter") # we'll want to display this form field on the application show page only if status is "In Progress"
    click_button("Submit Application")

    expect(current_path).to eq("/applications/#{@application_1.id}")

    expect(page).to have_no_content("Search") # may need to adjust this based on how user stories 4 and 5 are written
  end

  it "will not show the submit section if I have not added any pets" do
    visit "/applications/#{@application_with_no_pets.id}"

    save_and_open_page

    expect(page).to have_no_content("Why I would make a good owner")
    expect(page).to have_no_button("Submit Application")
  end

end
