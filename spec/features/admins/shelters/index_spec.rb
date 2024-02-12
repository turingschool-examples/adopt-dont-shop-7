require "rails_helper"

RSpec.describe "Admins Shelter Index" do
  before(:each) do
    @rithm = Shelter.create!(foster_program: true, name: "Rithm School", city: "Backend", rank: 3)
    @shelter_1 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @turing = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)
    @fsa = Shelter.create!(foster_program: true, name: "Fullstack Academy", city: "Backend", rank: 3)
    @codesmith = Shelter.create!(foster_program: true, name: "Codesmith", city: "Backend", rank: 3)
    @hackreactor = Shelter.create!(foster_program: true, name: "Hack Reactor", city: "Backend", rank: 3)

    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
    @pet_4 = @rithm.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love cats")
    @application_2 = Application.create!(name: "Jake", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love dogs", status: "Pending")
    @application_3 = Application.create!(name: "Jerry", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love hamsters", status: "Pending")
    @application_4 = Application.create!(name: "Jim", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love hamsters", status: "Pending")

    @application_pet_1 = ApplicationPet.create!(application_id: @application_4.id, pet_id: @pet_4.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_1.id)
    @application_pet_3 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_3.id)

    visit "/admin/shelters"
  end

  it "lists shelters in reverse alphabetical order by name" do
    # User Story 10
    expect("Turing").to appear_before("Rithm School")
    expect("Rithm School").to appear_before("Hack Reactor")
    expect("Hack Reactor").to appear_before("Fullstack Academy")
    expect("Fullstack Academy").to appear_before("Codesmith")
  end

  describe "Shelters with Pending Applications" do
    # User Story 11
    it "has its own section on the page" do
      expect(page).to have_content("Shelters with Pending Applications")
    end

    it "has a list of every shelter with a pending application" do
      within "#pending-#{@shelter_1.id}" do
        expect(page).to have_content("Fancy pets of Colorado")
      end

      within "#pending-#{@shelter_3.id}" do
        expect(page).to have_content("Aurora shelter")
      end

      within "#pending-#{@rithm.id}" do
        expect(page).to have_content("Rithm School")
      end
    end
  end

  describe "User Story 20 - Pending Applications Listed Alphabetically" do
    it "pending applications are listed alphabetically" do
      save_and_open_page
      within "#pending-applications" do
        expect("Aurora shelter").to appear_before("Fancy pets of Colorado")
        expect("Fancy pets of Colorado").to appear_before("Rithm")
      end
    end
  end

end
