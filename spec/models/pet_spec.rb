require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
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
    
    @susie = Application.create!(
      name: "Susie", 
      street_address: "5234 S Jamaica", 
      city: "Fargo", 
      state: "MI", 
      zip: "45896", 
      description: "Loves alligators.", 
      reason: "Trying a mammal on for size.",
      status: "Pending"
    )

    @tom = Application.create!(
      name: "Thomas", 
      street_address: "5234 S Jefferson", 
      city: "Julian", 
      state: "AL", 
      zip: "43896", 
      description: "Has owned a pet.", 
      reason: "Aspiring to own two.",
      status: "In Progress"
    )
    
    @susie_application_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @susie)
    @susie_application_pet_2 = ApplicationPet.create!(pet: @pet_2, application: @susie)

    @tom_application_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @tom, status: "Rejected")
    @tom_application_pet_2 = ApplicationPet.create!(pet: @pet_2, application: @tom)
    @tom_application_pet_3 = ApplicationPet.create!(pet: @pet_3, application: @tom)
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

    describe "#application_pet_status" do 
      it "returns the status of a the application_pet for specific pet and application" do 
        expect(@pet_1.application_pet_status(@susie.id)).to eq("Pending")
        expect(@pet_1.application_pet_status(@tom.id)).to eq("Rejected")
      end
    end
  end
end
