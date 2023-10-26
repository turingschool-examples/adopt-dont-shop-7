require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")

    @app_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @app_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_2.id)
    @app_pet_1.update(status: true)
    @app_pet_2.update(status: false)
  end

  describe "relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe "if the application pet is set for approval, it will check if the application given is the one that it was approved for" do
    it "can check if pet is approved and application is the same" do
      expect(@app_pet_1.approved(@application_2.id)).to eq(false)
      expect(@app_pet_1.approved(@application_1.id)).to eq(true)
    end

    it "can check if pet is rejected and application is the same" do
      expect(@app_pet_2.rejected(@application_1.id)).to eq(true)
      expect(@app_pet_2.rejected(@application_2.id)).to eq(false)
    end
  end

  describe "if the application pet is set for approval, it will check if the application given is the one that it was approved for" do
    it "can check if pet is approved and application is the same" do
      @app_pet_1.approve
      @app_pet_2.reject
      expect(@app_pet_1.approved(@application_2.id)).to eq(false)
      expect(@app_pet_1.approved(@application_1.id)).to eq(true)
    end

    it "can check if pet is rejected and application is the same" do
      @app_pet_1.approve
      @app_pet_2.reject
      expect(@app_pet_2.rejected(@application_1.id)).to eq(true)
      expect(@app_pet_2.rejected(@application_2.id)).to eq(false)
    end
  end

  describe "application pet approval" do
    before :each do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter_1.id)
      @application_1 = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
      @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")

      @app_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
      @app_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_2.id)
    end

    it 'can change the status of a pet to be true/approved' do
      expect(@app_pet_1.status).to be_nil
      @app_pet_1.approve
      expect(@app_pet_1.status).to be(true)
    end

    it 'can change the status of a pet to be true/approved' do
      expect(@app_pet_2.status).to be_nil
      @app_pet_2.reject
      expect(@app_pet_2.status).to be(false)
    end
  end
end
