require "rails_helper"

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it { should have_many(:pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create!(name: "Luis Aparicio", street_address: "7511 James St", city: "Menasha", state: "WI", zipcode: "54952", description: "I love pets!", application_status: "In Progress")
    @application_2 = Application.create!(name: "test", street_address: "test James St", city: "ena", state: "az", zipcode: "52332", description: "I love2 pets!",application_status: "In Progress")
    @application_3 = Application.create!(name: "Faisal", street_address: "12907 conquistador", city: "Spring Hill", state: "FL", zipcode: "34610", description: "I love pets")
    @application_4 = Application.create!(name: "Barry", street_address: "1234 Oxford St", city: "OKC", state: "OK", zipcode: "73122", description: "I love animals!",application_status: "Pending")
    @application_5 = Application.create!(name: "Larry David", street_address: "8888 Malibu Dr", city: "LA", state: "CA", zipcode: "10022", description: "I kind of like animals",application_status: "Pending")
  
    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id, pet_reason: "N/A")
    @application_pet_2 = ApplicationPet.create!(application_id: @application_4.id, pet_id: @pet_3.id, pet_reason: "N/A")
    @application_pet_3 = ApplicationPet.create!(application_id: @application_5.id, pet_id: @pet_4.id, pet_reason: "N/A")
  
  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe "#order_by_recently_created" do
      it "returns shelters with the most recently created first" do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe "#order_by_number_of_pets" do
      it "orders the shelters by number of pets they have, descending" do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    it "#reverse_alphabetical_order" do
      expect(Shelter.reverse_alphabetical_order).to eq([@shelter_2, @shelter_3, @shelter_1])
    end

    it "#pending_applications" do
      expect(Shelter.pending_applications).to eq([@shelter_3.name, @shelter_1.name])
    end
  end

  describe "instance methods" do
    describe ".adoptable_pets" do
      it "only returns pets that are adoptable" do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe ".alphabetical_pets" do
      it "returns pets associated with the given shelter in alphabetical name order" do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe ".shelter_pets_filtered_by_age" do
      it "filters the shelter pets based on given params" do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe ".pet_count" do
      it "returns the number of pets at the given shelter" do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end
  end
end
