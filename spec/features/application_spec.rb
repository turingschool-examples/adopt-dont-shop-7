require "rails_helper"

RSpec.describe "application" do
  before :each do
    @application_1 = Application.create!(
      name: "Bob",
      street_address: "123 Fake St",
      city: "Lander",
      state: "WY",
      zip: 82520,
      description: "I am loving and attentive.",
      status: "Accepted")
    @application_2 = Application.create!(
      name: "Sarah",
      street_address: "321 Faux Ln",
      city: "Salt Lake City",
      state: "UT",
      zip: 84104,
      description: "I live in a small apartment but am lonely so want a pet.",
      status: "In Progress")

    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @pet_application_1 = PetApplication.create!(pet: @pet_1, application: @application_1)
    @pet_application_2 = PetApplication.create!(pet: @pet_2, application: @application_1)
  end

  describe '/welcome' do 
    it "displays a link to all pets" do
      visit "/"
      expect(page).to have_content("Adopt, don't shop!")
      expect(page).to have_link("Pets")
      click_link("Pets")
      expect(page).to have_current_path("/pets")
    end

    it "displays a link to all shelters" do
      visit "/"

      expect(page).to have_link("Shelters")
      click_link("Shelters")
      expect(page).to have_current_path("/shelters")
      expect(page).to have_link("Shelters")
      expect(page).to have_link("Pets")
      expect(page).to have_link("Veterinarians")
      expect(page).to have_link("Veterinary Offices")
    end

    it "displays a link to all veterinary offices" do
      visit "/"

      expect(page).to have_link("Veterinary Offices")
      click_link("Veterinary Offices")
      expect(page).to have_current_path("/veterinary_offices")
      expect(page).to have_link("Shelters")
      expect(page).to have_link("Pets")
      expect(page).to have_link("Veterinarians")
      expect(page).to have_link("Veterinary Offices")
    end

    it "displays a link to all veterinarians" do
      visit "/"

      expect(page).to have_link("Veterinarians")
      click_link("Veterinarians")
      expect(page).to have_current_path("/veterinarians")
      expect(page).to have_link("Shelters")
      expect(page).to have_link("Pets")
      expect(page).to have_link("Veterinarians")
      expect(page).to have_link("Veterinary Offices")
    end
  end
end
