require "rails_helper"

RSpec.describe "admin shelters index" do 
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @cory = Application.create!(name:"Cory", street_address: "385 N Billups st.", city: "Athen", state: "GA", zipcode:"30606", description:"Extremely normal and can be trusted", status:"Pending" )
    @antoine = Application.create!(name:"Antoine", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"Pending" )
    @jeff = Application.create!(name:"Jeff", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"Pending" )

    @pet_applications_1 = PetApplication.create!(pet_id: "#{@pet_1.id}", application_id: "#{@cory.id}", status: "Pending" )
    @pet_applications_2 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@antoine.id}", status: "Pending" )
    @pet_applications_3 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@jeff.id}", status: "Pending" )
  end

  describe "all shelters reverse alphabetical order" do 
    it "lists all shelters in reverse alphabetical order by name" do 
      visit "/admin/shelters"

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end

  describe "pets with pending applications" do
    it "lists all shelters with pets that have pending applications" do
      visit "/admin/shelters"
      
      expect(page).to have_content("Shelters with Pending Applications")
      within("#pending_applications") do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_3.name)
      end
    end
  end
end