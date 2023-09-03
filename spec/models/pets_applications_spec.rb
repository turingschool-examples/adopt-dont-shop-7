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
        # expect(PetsApplication.find_application_for_approve(pet_1.id, dude.id)).to eq([application.id])
      end
    end
  end
end