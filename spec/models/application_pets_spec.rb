require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do

 describe 'relationships' do
  it { should belong_to :pet }
  it { should belong_to :application }
 end

 describe 'instance methods' do
  before do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: false)
    @pet_3 = @shelter_1.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
  
    @application_1 = Application.create!(name: "Selena", street_address: "123 Street", city: "City", state: "State", zip_code: "8888", adopting_reason: "Love for cats, no job", status:"Pending")
    @application_2 = Application.create!(name: "Laura", street_address: "58 Street", city: "City", state: "State", zip_code: "5555", adopting_reason: "Need company", status:"Pending")
    @application_3 = Application.create!(name: "Isaac", street_address: "456 Street", city: "City", state: "State", zip_code: "8878", adopting_reason: "Lots of love to give", status:"Approved")
    @application_4 = Application.create!(name: "Mark", street_address: "889 Folsom Ave", city: "Denver", state: "CO", zip_code: "80024", adopting_reason: "Lonely", status:"Approved")
  
    @application_pets_1 = ApplicationPet.create!(pet_id: @pet_3.id, application_id: @application_1.id)
    @application_pets_2 = ApplicationPet.create!(pet_id: @pet_4.id, application_id: @application_4.id)
    @application_pets_3 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_3.id)
  end

  describe "#status_update" do
    it "returns true when application is approved and pet is adoptable" do

      expect(@application_pets_2.status_update).to eq(true)
    end

    it "returns false when application is other than approved or pet is not adoptable" do

      expect(@application_pets_1.status_update).to eq(false)
      expect(@application_pets_3.status_update).to eq(false)
    end
  end
 end
end