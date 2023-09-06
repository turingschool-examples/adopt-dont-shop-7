require 'rails_helper'

RSpec.describe Application do
    describe "relationships" do
        it {should have_many(:pets).through(:pet_applications)}
        it {should have_many :pet_applications}
    end

    describe "validations" do
        it {should validate_presence_of :name}
        it {should validate_presence_of :street_address}
        it {should validate_presence_of :city}
        it {should validate_presence_of :state}
        it {should validate_presence_of :zip_code}
        it {should validate_presence_of :reason_for_adoption}
    end

    describe "find_pet_application_status" do
        it "returns the application status for a pet" do
          shelter_1 = Shelter.create(name: "Steven Shelter", city: "Fort Collins", foster_program: false, rank: 9)
          pet_1 = shelter_1.pets.create(name: "Pickles", breed: "Pig", age: 5, adoptable: true)
          pet_2 = shelter_1.pets.create(name: "Claws", breed: "Gator", age: 3, adoptable: true)
          pet_3 = shelter_1.pets.create(name: "Steven", breed: "Horse", age: 3, adoptable: false)

          application = Application.create(
            name: "James Dean",
            street_address: "456 Rock rd",
            city: "Rainbow Rd",
            state: "CA",
            zip_code: "15678",
            reason_for_adoption: "I need Steven",
            status: "pending"
          )
    
          PetApplication.create(pet: pet_3, application: application, application_status: "approved")
    
          expect(application.find_pet_application_status(pet_3.id)).to eq("approved")
        end
    end
end