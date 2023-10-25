require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "status enums" do
    it "returns different results for different statuses" do
      expect(ApplicationPet.statuses).to eq({"Pending" => 0, "Accepted" => 1, "Rejected" => 2})
      expect(ApplicationPet.statuses[:Pending]).to eq(0)
      expect(ApplicationPet.statuses["Accepted"]).to eq(1)
      expect(ApplicationPet.statuses[:Rejected]).to eq(2)
      expect(ApplicationPet.statuses["Test"]).to eq(nil)
    end
  end

  describe 'class methods' do
    before(:each) do
      @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "Pending")
      @application_2 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
      
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)

      @application_1.pets << @pet_1
    end

    describe 'current_app' do
      it 'returns current application' do
        expect(ApplicationPet.current_app(@application_1.id, @pet_1.id)).to eq(@application_1.application_pets)
      end
    end
  end

  describe 'instance methods' do
    before(:each) do
      @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "Pending")
      @application_2 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
      
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)

      @application_1.pets << @pet_1
    end

   describe '.pending?' do
     it 'returns true if Pending' do
       expect(@application_1.application_pets.first.pending?).to eq(true)
     end
   end
  end
end