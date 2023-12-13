require "rails_helper"

RSpec.describe Application, type: :model do
    describe "relationships" do
      it { should have_many(:pets) }
    end

    describe 'Validations' do
      it { should validate_presence_of :name}
      it { should validate_presence_of :street_address}
      it { should validate_presence_of :city}
      it { should validate_presence_of :state}
      it { should validate_presence_of :zip_code}
      it { should validate_numericality_of :zip_code}
      it { should validate_length_of :zip_code}
      it { should validate_presence_of :description}
    end

    before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
        @applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")

    end

    describe "#add_pet_to_application" do 
      it "adds a pet to the application" do 
        @applicant.add_pet_to_application(@pet_1.id)
        expect(@applicant.pets).to eq([@pet_1])
      end
    end

    describe "#change_application_status" do
      it "changes status from In Progress to Pending when application is submitted" do
        expect(@applicant.status).to eq("In Progress")

        @applicant.change_application_status("Pending")

        expect(@applicant.status).to eq("Pending")
      end
    end

    
end