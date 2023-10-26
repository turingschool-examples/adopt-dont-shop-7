require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
    it { should have_many(:application_pets) }
    it { should have_many(:applications).through(:application_pets) }
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

      it "updates pets adoptability" do
        application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Pending")
        application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", good_home: "5 solid meals a day", good_owner: "I like fish", status: "Pending")

        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

        pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        pet_2 = shelter_3.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        pet_3 = shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
        pet_4 = shelter_3.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
        pet_5 = shelter_3.pets.create(name: "QWERTY", breed: "sphynx", age: 8, adoptable: true)
        pet_6 = shelter_3.pets.create(name: "Ballistic Missile", breed: "sphynx", age: 8, adoptable: true)

        expect(Pet.update_adoptable(application1.id)).to eq([])
        application1.pets << pet_1
        expect(Pet.update_adoptable(application1.id)).to eq([pet_1])

        # expect(pet_1.adoptable).to be false

        application1.pets << pet_2
        application1.pets << pet_3
        expect(Pet.update_adoptable(application1.id)).to eq([pet_1, pet_2, pet_3])
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
