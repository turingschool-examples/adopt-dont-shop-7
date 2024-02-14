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
    @applicant1 = Application.create(name:"Tom Brady",street_address: "123 MVP drive", city: "Goat city", state: "CO", zip_code: 67878, description: "I'm the GOAT " )

  end

  describe '#status' do
    xit 'returns the status of of a pet on an application' do
      ApplicationPet.create!(pet: @pet_2, application: @applicant1, status:"Approved")
      ApplicationPet.create!(pet: @pet_1, application: @applicant1, status:"Rejected")
      ApplicationPet.create!(pet: @pet_3, application: @applicant1)
      expect(@pet_2.status(@applicant1)).to eq("Approved")
      expect(@pet_3.status(@applicant1)).to eq(nil)
      expect(@pet_1.status(@applicant1)).to eq("Rejected")
    end
  end

  describe '#choice_made' do
    xit 'checks if pet is rejected or approved on an application' do
      ApplicationPet.create!(pet: @pet_2, application: @applicant1, status:"Approved")
      ApplicationPet.create!(pet: @pet_1, application: @applicant1, status:"Rejected")
      ApplicationPet.create!(pet: @pet_3, application: @applicant1)
      
      expect(@pet_2.choice_made(@applicant1)).to eq(true)
      expect(@pet_1.choice_made(@applicant1)).to eq(true)
      expect(@pet_3.choice_made(@applicant1)).to eq(false)
    end
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

  describe '#find_pet' do
    it 'searches for specific name' do
      # require 'pry'; binding.pry
      expect(Pet.find_pet("Ann")).to eq([@pet_3])
    
    end
  end

end
