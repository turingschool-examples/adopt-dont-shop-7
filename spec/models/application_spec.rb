require "rails_helper"

RSpec.describe Application, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @cory = Application.create!(name:"Cory", street_address: "385 N Billups st.", city: "Athen", state: "GA", zipcode:"30606", description:"Extremely normal and can be trusted", status:"In Progress" )
    @antoine = Application.create!(name:"Antoine", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"In Progress" )

    PetApplication.create!(pet_id: @pet_1.id, application_id: @cory.id, status: "Pending")
    PetApplication.create!(pet_id: @pet_2.id, application_id: @cory.id, status: "Approved")
    PetApplication.create!(pet_id: @pet_1.id, application_id: @antoine.id, status: "Rejected")
    PetApplication.create!(pet_id: @pet_2.id, application_id: @antoine.id, status: "Rejected")
  end
  describe "realtionships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe "instance methods" do
    describe "#individual_pet_status" do
      it "returns the status of the pet on the specific application" do
        expect(@cory.individual_pet_status(@pet_1)).to eq("Pending")
        expect(@cory.individual_pet_status(@pet_2)).to eq("Approved")
        expect(@antoine.individual_pet_status(@pet_1)).to eq("Rejected")
        expect(@antoine.individual_pet_status(@pet_2)).to eq("Rejected")
      end
    end
  end
end