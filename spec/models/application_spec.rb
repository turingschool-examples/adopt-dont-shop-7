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
      @pet = @application_1.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
      @pet_2 = Pet.create(name: "Chicken", age: 3, breed: "Lab", adoptable: true, shelter_id: @shelter.id)
    end

    describe "get_pets" do
      it "returns an array of pets associated with the application" do
        expect(@application_1.get_pets).to eq([@pet])
      end
    end
  end
end