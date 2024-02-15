require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  describe "associations" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe "validations" do
    it {should validate_presence_of :application_id}
    it {should validate_presence_of :pet_id}
    it {should validate_inclusion_of(:application_approved).in_array([true, false])}
    it {should validate_exclusion_of(:application_approved).in_array([nil])}
    it {should validate_inclusion_of(:application_reviewed).in_array([true, false])}
    it {should validate_exclusion_of(:application_reviewed).in_array([nil])}
  end

  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_2 = Application.create!(name: "Jake", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love dogs", status: 1)
    @application_3 = Application.create!(name: "Jerry", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love hamsters", status: 1)

    @application_pet_1 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_1.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_3.id)
  end

  describe "instance methods" do
    describe "#pet_adopted?" do
      it "should return true for pets on an application that have been adopted" do
        expect(@application_pet_1.pet_adopted?).to eq(false)

        @pet_1.update!(adoptable: false)

        expect(@application_pet_1.pet_adopted?).to eq(true)
      end
    end
  end

  describe "callbacks" do
    describe "#update_pet" do
      it "updates the pet's adoptable attribute to false when ApplicationPet is approved AND ALL PETs are approved" do
        shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

        pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)

        application_2 = Application.create!(name: "Jake", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love dogs", status: 1)

        new_app = ApplicationPet.create!(application_id: application_2.id, pet_id: pet_2.id)
        application_pet_1 = ApplicationPet.create!(application_id: application_2.id, pet_id: pet_1.id)

        expect(pet_2.adoptable?).to eq(true)

        application_pet_1.update!(application_approved: true)

        expect(Pet.find(new_app.pet.id).adoptable?).to eq(true)

        new_app.update!(application_approved: true)

        expect(Pet.find(new_app.pet.id).adoptable?).to eq(false)
      end
    end

    describe "#update_application" do
      it "updates the applications's statis to 'Accepted' when ApplicationPet is approved" do
        new_app = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_2.id)

        expect(new_app.application.status).to eq("Pending")

        new_app.update!(application_approved: true)

        expect(new_app.application.status).to eq("Accepted")
      end
    end
  end
end
