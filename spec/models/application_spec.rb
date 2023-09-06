require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_inclusion_of(:status).in_array(["In Progress", "Pending", "Accepted", "Rejected"]) }
  end

  describe "instance methods" do
    before(:each) do
      @shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      @application_1 = Application.create(name: "John Dwayne", address: "1010 W 50th Ave, Denver, CO, 80020", description: "Background as a dog sitter", status: "In Progress")
      @application_2 = Application.create(name: "Wayne Zane", address: "2020 E 10th Ave, Denver, CO, 80020", description: "Has pets already", status: "In Progress")
      @pet = @application_1.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
      @pet_2 = Pet.create(name: "Chicken", age: 3, breed: "Lab", adoptable: true, shelter_id: @shelter.id)
    end

    describe "get_pets" do
      it "returns an array of pets associated with the application" do
        expect(@application_1.get_pets).to eq([@pet])
      end
    end

    describe "pet_names" do
      it "grabs the name attribute from pets" do
        names = @application_1.pet_names

        expect(names).to eq(["Scooby"])
      end
    end

    describe "pet_link(pet_name)" do
      it "grabs the link from that pet name" do
        link = @application_1.pet_link("Scooby")
        expect(link).to eq("/pets/#{@pet.id}")
      end
    end

    describe "add_pet(pet_id)" do
      it "adds a pet to the application" do
        @application_1.add_pet("#{@pet_2.id}")

        names = @application_1.pet_names

        expect(names).to eq(["Scooby", "Chicken"])
      end
    end

    describe "pets_exists?" do
      it "checks to see if application has any pets associated with it" do
        expect(@application_1.has_pets?).to be(true)
        expect(@application_2.has_pets?).to be(false)
      end
    end
  end
end