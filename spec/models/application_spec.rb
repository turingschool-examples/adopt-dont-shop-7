require "rails_helper"

RSpec.describe Application, type: :model do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")

    @app_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @app_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_2.id)
  end

  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
  end

  it 'can combine applicant address together' do
    expect(@application_1.address_join).to eq("#{@application_1.street_address}, #{@application_1.city}, #{@application_1.state}, #{@application_1.zip_code}")
  end

  it 'can change the status of the application if all pets are approved' do
    @app_pet_1.approve
    @application_1.change_status
    expect(@application_1.status).to eq("In Progress")
    @app_pet_2.approve
    @application_1.change_status
    # expect(@application_1.status).to eq("Approved")
  end

end

