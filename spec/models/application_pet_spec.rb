require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  before(:each) do
    @application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")

    @shelter = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)

    @dog = @shelter.pets.create(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
    @cat = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "cat")

    @application_pet_1 = ApplicationPet.create(application_id: @application_1.id, pet_id: @dog.id)
    @application_pet_2 = ApplicationPet.create(application_id: @application_1.id, pet_id: @cat.id)
  end

  describe "associations" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  describe "validations" do
    it {should validate_presence_of :application_id}
    it {should validate_presence_of :pet_id}
  end

  describe "#approve_or_deny" do
    xit "" do
      # placeholder
    end
  end
end
