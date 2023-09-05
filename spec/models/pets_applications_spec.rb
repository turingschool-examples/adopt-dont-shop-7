require "rails_helper"

RSpec.describe PetsApplication, type: :model do
  describe "relationships" do
    it { should belong_to(:pet).optional }
    it { should belong_to(:applicant) }
  end

  describe "class methods" do
    describe "find_application_for_approval" do
      it "finds the application using pet and app ids" do
        dude = Applicant.create!(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")
        jane = Applicant.create!(name: "jane", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")
        shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
        pet_2 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Barry")
        application = PetsApplication.create!(applicant: dude, pet: pet_1, status: "Pending")
        application_1 = PetsApplication.create!(applicant: jane, pet: pet_2)
        expect(PetsApplication.find_application(pet_1.id, dude.id)).to eq([application])
      end
    end
    describe "check_app_status" do
      it "grabs all PetApplications for an Applicant, and returns overall application status" do
        guy = Applicant.create!(name: "GUY", street_address: "Place", city: "somewhere", 
        state: "Texas", zip_code: "75248", description: "I love animals!")

        # expect(PetsApplication.check_app_status(guy)).to eq("In Progress")
        shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_3 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
        pet_4 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Barry")

        guy_app_1 = PetsApplication.create!(applicant: guy, pet: pet_3)
        guy_app_2 = PetsApplication.create!(applicant: guy, pet: pet_4)
        
        guy_app_1.update(status: "Pending")
        guy_app_2.update(status: "Pending")
        
        expect(PetsApplication.check_app_status(guy)).to eq("Pending")

        guy_app_1.update(status: "Accepted")
        expect(PetsApplication.check_app_status(guy)).to eq("Pending")

        guy_app_2.update(status: "Rejected")
        expect(PetsApplication.check_app_status(guy)).to eq("Rejected")

        guy_app_2.update(status: "Accepted")
        expect(PetsApplication.check_app_status(guy)).to eq("Approved")
      end
    end
  end
end