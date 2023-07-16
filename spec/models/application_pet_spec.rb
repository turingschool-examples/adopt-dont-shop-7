require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  describe "relationshps" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "validations" do
    it "validates the uniqueness of a pet_id associated with application_id" do
      mr_ape = Application.create(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "CO", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
      shelter_3 = Shelter.create(name: "Dumb Friends League", city: "Denver CO", foster_program: true, rank: 10)
      scooby = shelter_3.pets.create(adoptable: true, age: 2, breed: "Great Dane", name: "Scooby")

      ApplicationPet.create(application_id: mr_ape.id, pet_id: scooby.id)
      
      duplicate_pet_data = ApplicationPet.new(application: mr_ape, pet: scooby)
      duplicate_pet_data.valid?

      expect(duplicate_pet_data).not_to be_valid
      expect(duplicate_pet_data.errors.full_messages).to include("Application already has that pet.")
    end
  end
end