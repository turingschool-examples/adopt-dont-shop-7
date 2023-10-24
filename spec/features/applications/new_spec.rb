require "rails_helper"

RSpec.describe "Application New Page" do 
  before(:each) do 
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @application1 = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
  end

  describe "visiting the application new page" do 
    it "has a form to fill in with required fields to create an application" do
      visit "/applications/new"

      expect(page).to have_field(:name)
      expect(page).to have_field(:street_address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip_code)
      expect(page).to have_field(:description)
      expect(page).to have_button("Submit")
    end

    it "accepts user inputs and redirects us to the new application show page" do
      visit "/applications/new"

      fill_in(:name, with: "Frank")
      fill_in(:street_address, with: "123 Fake St.")
      fill_in(:city, with: "Normaltown")
      fill_in(:state, with: "FK")
      fill_in(:zip_code, with: "12345")
      fill_in(:description, with: "I love pets!")

      click_button("Submit")

      application = Application.last 

      expect(current_path).to eq("/applications/#{application.id}")

      expect(page).to have_content("Frank")
      expect(page).to have_content("123 Fake St.")
      expect(page).to have_content("Normaltown")
      expect(page).to have_content("FK")
      expect(page).to have_content("12345")
      expect(page).to have_content("I love pets!")
    end

    it "shows an error message when the form is not fully filled out
    and it redirects to the new applications page" do
      visit "/applications/new"

     
      fill_in(:street_address, with: "123 Fake St.")
      fill_in(:city, with: "Normaltown")
      fill_in(:state, with: "FK")
      fill_in(:zip_code, with: "12345")
      fill_in(:description, with: "I love pets!")

      click_button("Submit")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: Name can't be blank")
    end

  end
end