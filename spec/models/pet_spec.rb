require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
    it { should have_many(:pets_applications) }
    it { should have_many(:applicants).through(:pets_applications) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe "#adoptable" do
      it "returns adoptable pets" do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end

    describe "#pets_with_app_status" do
      it "shows pets ids and gives access to status" do
        dude = Applicant.create!(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")
        jane = Applicant.create!(name: "jane", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")
        shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
        pet_2 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Barry")
        application = PetsApplication.create!(applicant: dude, pet: pet_1, status: "Pending")
        application_1 = PetsApplication.create!(applicant: dude, pet: pet_2)

        expect(Pet.pets_with_app_status_by_sql(application)).to eq([pet_1, pet_2])
      end

    end
  end

  describe "instance methods" do
    describe ".shelter_name" do
      it "returns the shelter name for the given pet" do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe "relationships" do
    it "should show applicant relationship" do
      applicant_1 = Applicant.create!(name: "Josh", street_address: "21546", city: "kdjfk", state: "tx", zip_code: "1233", description: "124651")

      PetsApplication.create!(applicant: applicant_1, pet: @pet_1)
      PetsApplication.create!(applicant: applicant_1, pet: @pet_2)

      expect(applicant_1.pets).to eq([@pet_1, @pet_2])
      expect(@pet_1.applicants).to eq([applicant_1])
    end
  end

  describe "change_pet_status" do
    it "changes status of all pets on an application to false only if all pets have been Approved for adoption" do
      applicant_1 = Applicant.create!(name: "Josh", street_address: "21546", city: "kdjfk", state: "tx", zip_code: "1233", description: "124651")
      shelter_2 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_5 = shelter_2.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      pet_6 = shelter_2.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      app_1 = PetsApplication.create!(applicant: applicant_1, pet: pet_5)
      app_2 = PetsApplication.create!(applicant: applicant_1, pet: pet_6)

      expect(pet_5.adoptable).to eq(true)
      expect(pet_6.adoptable).to eq(true)

      Pet.change_pet_status(applicant_1)

      expect(pet_5.adoptable).to eq(true)
      expect(pet_6.adoptable).to eq(true)

      app_1.update(status: "Accepted")
      app_2.update(status: "Accepted")

      Pet.change_pet_status(applicant_1)
      
      expect(applicant_1.pets.first.adoptable).to eq(false)
      expect(applicant_1.pets.second.adoptable).to eq(false)
    end
  end
end