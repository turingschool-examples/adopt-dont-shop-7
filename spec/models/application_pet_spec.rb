require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do 
  describe 'relationship' do 
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "class methods" do 
    describe "#find_application_pet" do 
      before(:each) do 
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
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
        @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        @application_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @susie)
        @application_pet_2 = ApplicationPet.create!(pet: @pet_2, application: @susie)
      end

      it "finds a specific application_pet when given pet's and application's foreign keys" do 
        expect(ApplicationPet.find_application_pet(@pet_1.id, @susie.id)).to eq(@application_pet_1)
      end
    end
  end
end