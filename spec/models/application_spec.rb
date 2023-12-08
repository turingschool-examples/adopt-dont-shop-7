require "rails_helper"

RSpec.describe Application, type: :model do
  before(:each) do
    @application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321")
    @shelter = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)
    @dog = @shelter.pets.create(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "cat")
    @application_pet_1 = ApplicationPet.create(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create(application_id: @application_1.id, pet_id: @cat.id)
  end

  describe "#full_address" do
    it "will concatenate address fields" do
      address = ("1234 ABC Lane Turing, Backend 54321")

      expect(@application_1.full_address).to eq(address)
    end
  end

  describe "#list_of_pets" do
    it "will list pets that the applicant wants to adopt" do

      expect(@application_1.list_of_pets).to eq([@dog, @cat])
    end
  end
end
