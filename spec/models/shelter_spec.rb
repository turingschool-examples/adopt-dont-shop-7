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
    @application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Pending")
    @application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", good_home: "5 solid meals a day", good_owner: "I like fish", status: "Pending")

    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe "#order_by methods" do
      it "returns shelters with the most recently created first" do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end

      it 'Returns shelters order_by_sql' do
        expect(Shelter.order_by_sql).to eq([@shelter_2, @shelter_3, @shelter_1])
      end

      it "orders the shelters by number of pets they have, descending" do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '#Shelter Statistics Class Methods' do
      it 'Average Age of pets at a shelter' do
        expect(Shelter.age_stats(@shelter_1)).to eq(4.3)
        expect(Shelter.age_stats(@shelter_3)).to eq(8)
        expect(Shelter.age_stats(@shelter_2)).to eq(0)
      end

      it "Number of pets at a given shelter that are adoptable" do
        expect(Shelter.pet_count(@shelter_1)).to eq(2)
        expect(Shelter.pet_count(@shelter_3)).to eq(1)
        expect(Shelter.pet_count(@shelter_2)).to eq(0)
      end

      it "Has a brag board about how many pets from a shelter have found a new home" do
        application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", good_home: "5 solid meals a day", good_owner: "I like fish", status: "Approved")
        expect(Shelter.pets_with_homes(@shelter_1)).to eq(0)
        @pet_2.applications << application2
        expect(Shelter.pets_with_homes(@shelter_1)).to eq(1)
        @pet_1.applications << application2
        expect(Shelter.pets_with_homes(@shelter_1)).to eq(2)
      end
    end

    it "Finds shelter name and address returned via SQL" do
      expect(Shelter.name_and_address(@shelter_2.id)).to eq("#{@shelter_2.name} #{@shelter_2.city}")
      expect(Shelter.name_and_address(@shelter_1.id)).to eq("#{@shelter_1.name} #{@shelter_1.city}")
      expect(Shelter.name_and_address(@shelter_3.id)).to eq("#{@shelter_3.name} #{@shelter_3.city}")
    end

    it "Will find pending applicaitons per shelter" do
      expect(Shelter.pending_applications).to eq([])
      @application1.pets << @pet_1
      expect(Shelter.pending_applications).to eq([@shelter_1])
      @application2.pets << @pet_3
      expect(Shelter.pending_applications).to eq([@shelter_1, @shelter_3])
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
      it "filters the shelter pets based on given params: Adoptable pets by age" do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([ @pet_4])
        expect(@shelter_1.shelter_pets_filtered_by_age(3)).to eq([@pet_2, @pet_4])
      end
    end

    describe ".pet_count" do
      it "returns the number of pets at the given shelter" do
        expect(@shelter_1.pet_count).to eq(3)
        expect(@shelter_2.pet_count).to eq(0)
        expect(@shelter_3.pet_count).to eq(1)
      end
    end

    it "Will list all the pets with pedning applications" do
      expect(@shelter_1.pending_pets).to eq([])
      application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Pending")
      @pet_2.applications << application1
      expect(@shelter_1.pending_pets).to eq([@pet_2])
      @pet_1.applications << application1
      expect(@shelter_1.pending_pets).to eq([@pet_1, @pet_2])
    end
  end
end
