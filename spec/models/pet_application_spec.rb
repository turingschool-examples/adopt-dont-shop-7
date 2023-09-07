require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "class methods" do
    describe "#find_pet_app" do
      it "returns a pet application given a pet_id and application_id" do
        application_1 = Application.create!(name: "Tyler Blackmon", address: "1234 Test St, Colorado Springs, CO, 80922", description: "This is why I'd be a good home!", status: "In Progress")
        application_2 = Application.create!(name: "Josh Blackmon", address: "4321 Another Test St, Colorado Springs, CO, 80922", description: "My description is too good", status: "In Progress")
        shelter_1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Greate Dane", adoptable: true, shelter_id: shelter_1.id)
        pet_2 = Pet.create!(name: "Chicken", age: 6, breed: "Actually A Bird", adoptable: true, shelter_id: shelter_1.id)
        pet_3 = application_2.pets.create!(name: "Kiwi", age: 5, breed: "Actually A Kiwi", adoptable: true, shelter_id: shelter_1.id)
        pet_application_1 = PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id, status: "Pending")
        
        expect(PetApplication.find_pet_app(application_1.id, pet_1.id)).to eq(pet_application_1)
      end
    end
  end
end