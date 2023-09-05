require "rails_helper"


RSpec.describe PetApplication, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @antoine = Application.create!(name:"Antoine", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"Pending" )
    @jeff = Application.create!(name:"Jeff", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"Pending")
    @pet_applications_1 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@antoine.id}", status: "Pending" )
    @pet_applications_3 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@jeff.id}", status: "Pending" )

  end

  describe "realtionships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "validations" do 
    it{ should validate_presence_of :application_id}
    it{ should validate_presence_of :pet_id}
    it{ should validate_presence_of :status}
  end

  describe "class methods" do 
    describe "#find_pet_application" do
      it "returns the pet application for the given pet and application" do
        expect(PetApplication.find_pet_application(@antoine.id, @pet_3.id, )).to eq(@pet_applications_1)
      end 
    end 
  end
end