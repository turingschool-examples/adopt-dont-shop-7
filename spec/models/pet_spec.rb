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
  end
  
  # USER STORY 8
  it "returns partial match for pet names" do
    expect(Pet.search("Mr.")).to eq([@pet_1])
  end

  it "has an application approval verification for the pet" do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @app_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @app_pet_1.approve
    expect(@pet_1.application_approved?).to eq(true)
  end
end
