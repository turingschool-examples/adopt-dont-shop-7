require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
    describe "relationships" do
      it { should belong_to(:pet) }
      it { should belong_to(:application) }
    end

    before(:each) do
      @shelter_1 = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "New Shelter", city: "Irvine CA", foster_program: false, rank: 9)
      @applicant_who_has_pets = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because",status:"Pending")
      @pet = @applicant_who_has_pets.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter_1.id)

    end

    describe "#change_application_pet_status" do 
      it "changes an application pet's status" do 
        application_pet = ApplicationPet.where({pet_id: @pet.id},{application_id: @applicant_who_has_pets.id}).first

        expect(application_pet.status).to eq(nil)

        application_pet.change_application_pet_status("fart")

        expect(application_pet.status).to eq("fart")
      end
    end   
end