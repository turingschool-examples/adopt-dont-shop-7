require "rails_helper"

RSpec.describe Applicant, type: :model do
  describe "relationships" do
    it { should have_many(:pets_applications) }
    it { should have_many(:pets).through(:pets_applications) }
  end

  describe "relationships" do
    it "should show applicant relationship" do
      applicant_1 = Applicant.create!(name: "Josh", street_address: "21546", city: "kdjfk", state: "tx", zip_code: "1233", description: "124651")
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)

      PetsApplication.create!(applicant: applicant_1, pet: pet_1)
      PetsApplication.create!(applicant: applicant_1, pet: pet_2)

      expect(applicant_1.pets).to eq([pet_1, pet_2])
      expect(pet_1.applicants).to eq([applicant_1])
    end
  end
end