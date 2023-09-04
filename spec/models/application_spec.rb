require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_inclusion_of(:status).in_array(["In Progress", "Pending", "Accepted", "Rejected"]) }
  end

  describe "#searched_pets" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Claus Home", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: "Claudia", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: "Claude", breed: "ragdoll", age: 3, adoptable: false)
      @application = Application.create!(name: "John Smith", street_address: "123 Main st", city: "Boulder", state: "CO", zip_code: "12345", description: "I'm rich.", status: "In Progress")
    end

    # US 8
    it "displays partial matches for pet names" do
      expect(@application.searched_pets("Cla")).to eq([@pet_1, @pet_2, @pet_3])
    end

    # US 9
    it "is case insensitive for pet names" do
      expect(@application.searched_pets("cla")).to eq([@pet_1, @pet_2, @pet_3])
    end
  end
end