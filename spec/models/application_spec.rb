require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "#searched_pet" do
    before :each do
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
      @pet_4 = Pet.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false, shelter_id: @shelter.id)
      @pet_5 = Pet.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter.id)
      @pet_6 = Pet.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true, shelter_id: @shelter.id)
    end

    it "will find partial matches for a pets name" do
      params = {:search => "Mr"}
      expect(Application.searched_pet(params)).to eq([@pet_4])
      params = {:search => "Claw"}
      expect(Application.searched_pet(params)).to eq([@pet_5])
      params = {:search => "le Ba"}
      expect(Application.searched_pet(params)).to eq([@pet_1])
    end

    it "Is case insensitive for pet searches" do
      params = {:search => "mr. pirate"}
      expect(Application.searched_pet(params)).to eq([@pet_4])
      params = {:search => "cLawdia"}
      expect(Application.searched_pet(params)).to eq([@pet_5])
      params = {:search => "LUCILLE BALD"}
      expect(Application.searched_pet(params)).to eq([@pet_1])
    end
  end

end