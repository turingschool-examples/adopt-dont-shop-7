require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")

    @shelter = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "Cat")

    @application_pet_1 = ApplicationPet.create(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create(application_id: @application_1.id, pet_id: @cat.id)
  end

  it "has application details" do

    visit "/applications/#{@application_1.id}"
#  When I visit an applications show page
#  Then I can see the following:
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.full_address) #instance method to put together address
    expect(page).to have_content(@application_1.description)
    expect(page).to have_link("#{@dog.name}") #instance method to query application_pets
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
      application = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321")
      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_content("Search for Pets by name:")
      expect(page).to have_no_content("Dog")
      expect(page).to have_button("Submit")

      fill_in("Search for Pets by name:", with: "Dog")
      click_button("Submit")

      expect(page.current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Dog")
      save_and_open_page
    end
  end

end
