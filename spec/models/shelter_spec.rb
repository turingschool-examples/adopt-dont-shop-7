require "rails_helper"

RSpec.describe Shelter, type: :model do
  let!(:shelter_1) {Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
  let!(:shelter_2) {Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)}
  let!(:shelter_3) {Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)}

  let!(:pet_1) {shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)}
  let!(:pet_2) {shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)}
  let!(:pet_3) {shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)}
  let!(:pet_4) {shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)}
  let!(:pet_5) {shelter_2.pets.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Pongo")}
  let!(:pet_6) {shelter_3.pets.create!(adoptable: true, age: 1, breed: "dalmatian", name: "Pongo II")}

  let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "pending")}
  let!(:application_2) {Application.create!(name: "Marcus", street_address: "100 Hennepin Ave.", city: "Minneapolis", state: "MN", zip_code: "55401", description: "Dogs are the best. Please let me have one.", status: "pending")}

  let!(:application_pet_1) {ApplicationPet.create!(pet: pet_1, application: application_1)}
  let!(:application_pet_2) {ApplicationPet.create!(pet: pet_5, application: application_2)}

  describe "relationships" do
    it { should have_many(:pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        expect(Shelter.search("Fancy")).to eq([shelter_3])
      end
    end

    describe "#order_by_recently_created" do
      it "returns shelters with the most recently created first" do
        expect(Shelter.order_by_recently_created).to eq([shelter_3, shelter_2, shelter_1])
      end
    end

    describe "#order_by_number_of_pets" do
      it "orders the shelters by number of pets they have, descending" do
        expect(Shelter.order_by_number_of_pets).to eq([shelter_1, shelter_3, shelter_2])
      end
    end

    it "#order_by_reverse_alphabetical" do
      expect(Shelter.order_by_reverse_alphabetical).to eq([shelter_2, shelter_3, shelter_1])
    end

    it "#have_pending_applications" do
      expect(Shelter.have_pending_applications).to eq([shelter_1.name, shelter_2.name])
    end
  end

  describe "instance methods" do
    describe ".adoptable_pets" do
      it "only returns pets that are adoptable" do
        expect(shelter_1.adoptable_pets).to eq([pet_2, pet_4])
      end
    end

    describe ".alphabetical_pets" do
      it "returns pets associated with the given shelter in alphabetical name order" do
        expect(shelter_1.alphabetical_pets).to eq([pet_4, pet_2])
      end
    end

    describe ".shelter_pets_filtered_by_age" do
      it "filters the shelter pets based on given params" do
        expect(shelter_1.shelter_pets_filtered_by_age(5)).to eq([pet_4])
      end
    end

    describe ".pet_count" do
      it "returns the number of pets at the given shelter" do
        expect(shelter_1.pet_count).to eq(3)
      end
    end
  end
end
