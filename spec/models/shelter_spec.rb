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

    describe "#admin_sort_reverse_alpha" do
      it "orders shelters in reverse alphabetical order" do
        expect(Shelter.admin_sort_reverse_alpha).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe "#with_pending_applications" do
      it "filters all of the shelters that have pending applications" do
        shelter1 = Shelter.create!(foster_program: true, name: "Bishop Animal Rescue", city: "Bishop", rank: 5)
        pet1 = shelter1.pets.create!(adoptable: true, age: 3, breed: "Samoyed", name: "Fluffy")
        pet2 = shelter1.pets.create!(adoptable: true, age: 6, breed: "Husky", name: "Hubert")
        # ^ not applied by anyone
        pet3 = shelter1.pets.create!(adoptable: true, age: 8, breed: "Shiba Inu", name: "Shishi")

        shelter2 = Shelter.create!(foster_program: true, name: "Chicago Animal Rescue", city: "Chicago", rank: 4)
        pet4 = shelter2.pets.create!(adoptable: true, age: 1, breed: "Lab", name: "Lally")
        pet5 = shelter2.pets.create!(adoptable: true, age: 10, breed: "Chihuahua", name: "Chewy")

        shelter3 = Shelter.create!(foster_program: true, name: "Los Angeles Animal Rescue", city: "Los Angeles", rank: 3)
        pet6 = shelter3.pets.create!(adoptable: true, age: 5, breed: "Pitbull", name: "Bully")

        app1 = Application.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled", status: "In Progress")
        petapp1 = PetApplication.create!(application_id: app1.id, pet_id: pet1.id)
        petapp2 = PetApplication.create!(application_id: app1.id, pet_id: pet4.id)

        app2 = Application.create!(name: "Andy", street_address: "456 Downtown", city: "Anywhere", state: "HI", zip_code: "23456", description: "Anotha One -DJ Khaled", status: "Pending")
        petapp3 = PetApplication.create!(application_id: app2.id, pet_id: pet1.id)
        petapp4 = PetApplication.create!(application_id: app2.id, pet_id: pet3.id)
        petapp5 = PetApplication.create!(application_id: app2.id, pet_id: pet6.id)

        app3 = Application.create!(name: "Jeff", street_address: "567 Sideways", city: "Somewhere", state: "DE", zip_code: "34567", description: "We the best -DJ Khaled", status: "Rejected")
        petapp6 = PetApplication.create!(application_id: app3.id, pet_id: pet5.id)

        result = [shelter1, shelter3]

        expect(Shelter.with_pending_applications).to eq(result)
      end
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
