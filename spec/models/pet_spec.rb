require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
    it { should have_many(:application_pets)}
    it { should have_many(:applications).through(:application_pets)}
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
  end

  describe "instance methods" do
    describe ".shelter_name" do
      it "returns the shelter name for the given pet" do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe "#find_application_pet(application_id)" do
      it "can find the application pets record for itself and the passed in application id" do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        application_1 = Application.create!(name: "Test 1", street_address: "123 street", city: "denver", state: "co", zip_code: 80023, endorsement: "Still the raddest", status: "Pending")
        application_2 = Application.create!(name: "Test 1", street_address: "123 street", city: "denver", state: "co", zip_code: 80023, endorsement: "Still the raddest", status: "Pending")
        application_pet_1 = ApplicationPet.create!(application_id: application_1.id, pet_id: pet_1.id)
        application_pet_2 = ApplicationPet.create!(application_id: application_2.id, pet_id: pet_1.id)

        expect(pet_1.find_application_pets(application_2.id)).to eq(application_pet_2)
      end
    end
  end
end
