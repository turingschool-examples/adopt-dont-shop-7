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
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        # As a visitor US8
        # When I visit an application show page
        # And I search for Pets by name
        # Then I see any pet whose name PARTIALLY matches my search
        # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
        expect(Pet.search("Claw")).to eq([@pet_2])
      end

      it "returns case insensitive matches" do
        # As a visitor US9
        # When I visit an application show page
        # And I search for Pets by name
        # Then my search is case insensitive
        # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
        expect(Pet.search("pirate")).to eq([@pet_1])
      end

      it "returns all animals on empty query" do
        expect(Pet.search("")).to eq([@pet_1, @pet_2, @pet_3])
      end
    end

    describe "#adoptable" do
      it "returns adoptable pets" do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
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
