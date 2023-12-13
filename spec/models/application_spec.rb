require "rails_helper"

RSpec.describe Application, type: :model do
  before(:each) do
    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")
    @application_2 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")

    @shelter = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create!(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create!(adoptable: true, age: 1, breed: "Tabby", name: "cat")

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @cat.id)
  end

  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street_address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zipcode}
    it { should validate_numericality_of :zipcode}
    it { should validate_presence_of :description}
  end

  describe "assocations" do
    it {should have_many :application_pets}
  end

  describe "#full_address" do
    it "will concatenate address fields" do
      address = ("1234 ABC Lane Turing, Backend 54321")

      expect(@application_1.full_address).to eq(address)
    end
  end

  describe "#all_pets_approved" do
    it "returns true, false, or nil depending on the approval status of all pets on a given application" do
      expect(@application_1.all_pets_approved).to eq(nil)

      @application_pet_1.update!(application_approved: true)
      @application_pet_2.update!(application_approved: false)

      expect(@application_1.all_pets_approved).to eq(false)

      @application_pet_1.update!(application_approved: true)
      @application_pet_2.update!(application_approved: true)

      expect(@application_1.all_pets_approved).to eq(true)
    end
  end

  describe "#status_of_application_pet" do
    it "returns the statuses of application pets for a given application" do
      expect(@application_1.status_of_application_pet).to eq([nil, nil])

      @application_pet_1.update!(application_approved: true)
      @application_pet_2.update!(application_approved: false)

      expect(@application_1.status_of_application_pet).to eq([true, false])
    end
  end

  describe "#list_of_pets" do
    it "will list pets that the applicant wants to adopt" do

      expect(@application_1.list_of_pets).to eq([@dog, @cat])
    end
  end

  describe "#added_pets?" do
    it "will check if there are any pets in #list_of_pets and return true or false" do
      expect(@application_1.added_pets?).to eq true
      expect(@application_2.added_pets?).to eq false
    end
  end
end
