require 'rails_helper' 

RSpec.describe Application, type: :model do 
  describe "Validaitons" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end
  describe "Relationships" do
    it{should have_many(:pet_applications)}
    it{should have_many(:pets).through(:pet_applications)}
  end

  before(:each) do 
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @application1 = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @application2 = Application.create(name: "Sally", street_address: "333 Not Real Pl.", city: "Pleasentville", state: "PO", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @application3 = Application.create(name: "Jack Skellington", street_address: "Ooky Spooky Lane", city: "Halloweentown", state: "PO", zip_code: 12345, description: "I love pets!", status: "In Progress")

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @pet_4 = @shelter_1.pets.create(name: "Mr. Bond", breed: "tabby", age: 3, adoptable: true)

    @pet_app_1 = PetApplication.create!(application_id: "#{@application1.id}", pet_id: "#{@pet_1.id}", status: "Pending")
    @pet_app_2 = PetApplication.create!(application_id: "#{@application2.id}", pet_id: "#{@pet_2.id}", status: "Approved")
    @pet_app_3 = PetApplication.create!(application_id: "#{@application2.id}", pet_id: "#{@pet_3.id}", status: "Rejected")
    @pet_app_4 = PetApplication.create!(application_id: "#{@application3.id}", pet_id: "#{@pet_1.id}", status: "Rejected")

  end

  describe "instance methods" do
    describe "#pet_app_status" do
      it "shows the status of the pet_application associated with the application_id and the pet_id" do
        expect(@application1.pet_app_status(@pet_1)).to eq("Pending")
        expect(@application2.pet_app_status(@pet_2)).to eq("Approved")
        expect(@application2.pet_app_status(@pet_3)).to eq("Rejected")
        expect(@application3.pet_app_status(@pet_1)).to eq("Rejected")

      end
    end
  end
end 