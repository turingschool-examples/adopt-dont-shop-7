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

    describe "status_check" do
      it "can return or update self.status based on application status of all pet_applications" do
        @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
        @pet_1 = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
        @pet_2 = @shelter.pets.create!(name: 'Buddy', breed: 'gorilla', age: 5, adoptable: true)
        @pet_3 = @shelter.pets.create!(name: 'Chairman Meow', breed: 'cat', age: 1, adoptable: true)
        @pet_4 = @shelter.pets.create!(name: 'Yogi', breed: 'bear', age: 35, adoptable: true)
        @pet_5 = @shelter.pets.create!(name: 'Scooby', breed: 'great dane', age: 6, adoptable: true)
        @pet_6 = @shelter.pets.create!(name: 'Scrappy', breed: 'great dane', age: 2, adoptable: true)
        @applicant_1 = Application.create!(name: 'Steven', 
          street_address: '1234 main st.', 
          city: 'Westminster', 
          state: 'CO',
          zip_code: '80020', 
          reason_for_adoption: "I want the pig",
          status: "Pending"
        )
        @applicant_2 = Application.create!(name: 'Tyler', 
          street_address: '1234 main st.', 
          city: 'Westminster', 
          state: 'CO',
          zip_code: '80020', 
          reason_for_adoption: "I want the pig",
          status: "Pending"
        )
        @applicant_3 = Application.create!(name: 'Shaggy', 
          street_address: '1234 main st.', 
          city: 'Westminster', 
          state: 'CO',
          zip_code: '80020', 
          reason_for_adoption: "Need a mystery solving dog",
          status: "Pending"
        )
        
        expect(@applicant_1.status_check).to eq("Pending")

        PetApplication.create!(pet_id: @pet_1.id, application_id: @applicant_1.id, application_status: "Rejected")
        PetApplication.create!(pet_id: @pet_4.id, application_id: @applicant_1.id, application_status: "Approved")

        expect(@applicant_1.status_check).to eq("Rejected")

        PetApplication.create!(pet_id: @pet_1.id, application_id: @applicant_2.id, application_status: "Approved")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @applicant_2.id, application_status: "Approved")
        PetApplication.create!(pet_id: @pet_3.id, application_id: @applicant_2.id, application_status: "Approved")

        expect(@applicant_2.status_check).to eq("Approved")

        PetApplication.create!(pet_id: @pet_5.id, application_id: @applicant_3.id, application_status: "Approved")
        PetApplication.create!(pet_id: @pet_6.id, application_id: @applicant_3.id, application_status: "Pending")

        expect(@applicant_3.status_check).to eq("Pending")
      end
    end

    describe "find_if_adoptable" do
      it "can return if a pet is adoptable" do
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
  
        PetApplication.create(pet: pet_1, application: application, application_status: "Pending")
        PetApplication.create(pet: pet_3, application: application, application_status: "Approved")
  
        expect(application.find_if_adoptable(pet_1.id)).to be true
        expect(application.find_if_adoptable(pet_3.id)).to be false
      end
    end
end