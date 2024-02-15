require "rails_helper"

RSpec.describe "Admin Applications Index Page" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @turing = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)
    @fsa = Shelter.create!(foster_program: true, name: "Fullstack Academy", city: "Backend", rank: 3)
    @codesmith = Shelter.create!(foster_program: true, name: "Codesmith", city: "Backend", rank: 3)
    @rithm = Shelter.create!(foster_program: true, name: "Rithm School", city: "Backend", rank: 3)
    @hackreactor = Shelter.create!(foster_program: true, name: "Hack Reactor", city: "Backend", rank: 3)

    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love cats")
    @application_2 = Application.create!(name: "Jake", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love dogs", status: 1)
    @application_3 = Application.create!(name: "Jerry", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love hamsters", status: 1)

    @application_pet_1 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_1.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_3.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_3.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_4.id)

    visit "/admin/applications"
  end

  describe "Extra Information - Displays stats about an Application" do
    it "displays every application's information" do
      Application.all.each do |application|
        within "#application-#{application.id}" do
          expect(page).to have_content(application.name)
          expect(page).to have_button("View Application")
          expect(page).to have_button("Edit Application")
        end

        within "#application-#{@application_2.id}" do
          expect(page).to have_content("Number of pets applied for: 2")
          expect(page).to have_content("Application status: Pending")

          within "#application-pet-#{@application_pet_1.id}" do
            expect(page).to have_content("Pet Application ID: #{@application_pet_1.id}")
            expect(page).to have_content("Application reviewed? No")
            expect(page).to have_content("Application approved? No")
          end
        end
      end
    end
  end
end
