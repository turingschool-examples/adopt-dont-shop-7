require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
    it { should_not validate_uniqueness_of(:name) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
  end

  describe "class methods" do
    describe "#search" do
      it 'returns exact matches' do
        expect(Pet.search("Clawdia")).to eq([@pet_2])
        expect(Pet.search("Clawdia")).to_not eq([@pet_3])
      end

      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
        expect(Pet.search("Claw")).to_not eq([@pet_3])
      end

      it 'returns case insensitive matches' do
        expect(Pet.search("CLAW")).to eq([@pet_2])
        expect(Pet.search("CLAW")).to_not eq([@pet_3])
        expect(Pet.search("claw")).to eq([@pet_2])
        expect(Pet.search("claw")).to_not eq([@pet_3])
        expect(Pet.search("ClAw")).to eq([@pet_2])
        expect(Pet.search("ClAw")).to_not eq([@pet_3])
      end

      it 'returns no matches if no matches found' do
        expect(Pet.search("charlie")).to eq([])
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
  end
end
