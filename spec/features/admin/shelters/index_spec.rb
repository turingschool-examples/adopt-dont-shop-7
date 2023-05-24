require 'rails_helper'

RSpec.describe "/admin/shelters" do 
  before(:each) do 
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

    @susie = Application.create!(
      name: "Susie", 
      street_address: "5234 S Jamaica", 
      city: "Fargo", 
      state: "MI", 
      zip: "45896", 
      description: "Loves alligators.", 
      status: "Pending"
    )

    @tom = Application.create!(
      name: "Thomas", 
      street_address: "5234 S Jefferson", 
      city: "Julian", 
      state: "AL", 
      zip: "43896", 
      description: "Has owned a pet.", 
      status: "In Progress"
    )
    
    ApplicationPet.create!(pet: @pet_1, application: @susie)
    ApplicationPet.create!(pet: @pet_2, application: @susie)
    
    ApplicationPet.create!(pet: @pet_1, application: @tom)
    ApplicationPet.create!(pet: @pet_2, application: @tom)
    ApplicationPet.create!(pet: @pet_3, application: @tom)
  end

  #User Story 10
  describe "Admin Shelters Index" do 
    it "displays all shelters in the system in reverse alphabetical order by name" do
      visit "/admin/shelters" 
      within("#all-shelters") do 
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
        expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
      end
    end
  end

  #User Story 11
  describe "Shelters With Pending Applications" do 
    it "displays shelters with pending applications" do 
      visit "/admin/shelters"
      within("#shelters-with-pending") do 
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).to_not have_content(@shelter_3.name)
      end
    end
  end
end