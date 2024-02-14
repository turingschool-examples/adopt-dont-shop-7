require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "pending")}

  let!(:shelter_1) {Shelter.create!(foster_program: true, name: "Adopters Unite", city: "Minneapolis", rank: 1 ) }

  let!(:pet_1) {shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Rover")}
  let!(:pet_2) {shelter_1.pets.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Pongo")}

  let!(:application_pet_1) {ApplicationPet.create!(pet: pet_1, application: application_1)}
  let!(:application_pet_2) {ApplicationPet.create!(pet: pet_2, application: application_1)}

  describe "relationships" do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  describe "#approve" do
    it "updates pet_status to 'approved'" do
      application_pet_1.approve
      application_pet_2.approve
      expect(application_pet_1.pet_status).to eq("approved")
      expect(application_1.status).to eq("approved")
    end
  end

  describe "#reject" do
    it "updates pet_status to 'rejected'" do
      application_pet_1.reject
      application_pet_2.approve
      expect(application_pet_1.pet_status).to eq("rejected")
      expect(application_pet_2.pet_status).to eq("approved")
      expect(application_1.status).to eq("rejected")
    end
  end
end
