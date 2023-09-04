require "rails_helper"

RSpec.describe "Admin Shelters Page" do
  describe "complete shelter list" do
    it "can list all shelters by reverse alphabetical order" do
      broadway = Shelter.create!(foster_program: true, name: "Broadway", city: "Denver", rank: 7)
      englewood = Shelter.create!(foster_program: true, name: "Englewood", city: "Denver", rank: 7)
      colemine = Shelter.create!(foster_program: true, name: "Colemine", city: "Denver", rank: 7)
      arapahoe = Shelter.create!(foster_program: true, name: "Arapahoe", city: "Denver", rank: 7)
      denver = Shelter.create!(foster_program: true, name: "Denver", city: "Denver", rank: 7)

      visit "/admin/shelters"
      
      expect("Englewood").to appear_before("Denver")
      expect("Denver").to appear_before("Colemine")
      expect("Colemine").to appear_before("Broadway")
      expect("Broadway").to appear_before("Arapahoe")
    end
  end
  describe "shelters with applicants list" do
    it "can display shelters with application submitted" do
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
      
      pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
      pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      pet_3 = shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
      pet_4 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
      
      charlie = Application.create!(applicant_name: "Charlie Brown", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Charlie has been looking forward to picking out a friend", application_status: "Pending")
      joop = Application.create!(applicant_name: "Joop", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Really, really good looking", application_status: "Pending")  
      ApplicationPet.create!(pet: pet_2, application: charlie)
      ApplicationPet.create!(pet: pet_3, application: joop)
      
      visit "/admin/shelters"
      
      expect(find("#with_application")).to have_content("Aurora shelter")
      expect(find("#with_application")).to have_content("Fancy pets")
      expect(find("#with_application")).to_not have_content("RGV")
    end
  end


end