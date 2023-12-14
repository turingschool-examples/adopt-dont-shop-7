require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
    describe "relationships" do
      it { should belong_to(:pet) }
      it { should belong_to(:application) }
    end

    before(:each) do
      @shelter_1 = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "New Shelter", city: "Irvine CA", foster_program: false, rank: 9)
      @shaggy = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because", status:"Pending")
      @daphne = Application.create(name: "Daphne", street_address: "4 North Street", city: "Boulder", state: "CO", zip_code: "80209", description: "I want a pet", status:"Pending")
      @scooby = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter_1.id)
      @shaggy.add_pet_to_application(@scooby.id)
      @daphne.add_pet_to_application(@scooby.id)
    end

    describe "#change_application_pet_status" do 
      it "changes an application pet's status" do 
        application_pet = ApplicationPet.where({pet_id: @scooby.id, application_id: @shaggy.id}).first

        expect(application_pet.status).to eq(nil)

        application_pet.change_application_pet_status("fart")

        expect(application_pet.status).to eq("fart")
      end

      it "does not change a different application pet's status when there are two or more applications for the same pet" do
        application_pet_1 = ApplicationPet.where({pet_id: @scooby.id, application_id: @shaggy.id}).first
        application_pet_2 = ApplicationPet.where({pet_id: @scooby.id, application_id: @daphne.id}).first

        expect(application_pet_1.status).to eq(nil)
        expect(application_pet_2.status).to eq(nil)

        application_pet_1.change_application_pet_status("fart")
        expect(application_pet_1.status).to eq("fart")
        expect(application_pet_2.status).to_not eq("fart")
      end
    end   
end