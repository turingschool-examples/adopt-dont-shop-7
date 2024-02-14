require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
    before(:each) do
      @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
      @application_4 = Application.create!(name: "Barry", street_address: "1234 Oxford St", city: "OKC", state: "OK", zipcode: "73122", description: "I love animals!",application_status: "Pending")
      @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
      @application_pet_2 = ApplicationPet.create!(application_id: @application_4.id, pet_id: @pet_3.id, pet_reason: "N/A")
    end
    it "approves an application pet" do
      expect(@application_pet_2.pet_adoptable).to eq("N/A")
      @application_pet_2.approve
      expect(@application_pet_2.pet_adoptable).to eq("approve")
    end

    it "rejects an application pet" do
      expect(@application_pet_2.pet_adoptable).to eq("N/A")
      @application_pet_2.reject
      expect(@application_pet_2.pet_adoptable).to eq("reject")
    end

    it "updates reason" do
      expect(@application_pet_2.pet_reason).to eq("N/A")
      @application_pet_2.change_reason("test")
      expect(@application_pet_2.pet_reason).to eq("test")
    end
  end
end 