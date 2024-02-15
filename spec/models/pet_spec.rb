require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")

    @shelter = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create!(adoptable: true, age: 1, breed: "Tabby", name: "cat")

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @cat.id)
  end

  describe "class methods" do
    describe ".adoptable" do
      it "returns adoptable pets" do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2, @dog, @cat])
      end
    end

    describe ".check_pet_applications" do
      it "returns true if all pets on an application have been approved" do

        expect(Pet.check_pet_applications).to eq([false, false])

        @application_pet_2.update_attribute(:application_approved, true)

        expect(Pet.check_pet_applications).to eq([false, true])

        @application_pet_1.update_attribute(:application_approved, true)

        expect(Pet.check_pet_applications).to eq([true, true])
      end
    end
  end

  describe "instance methods" do
    describe "#shelter_name" do
      it "returns the shelter name for the given pet" do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end
end
