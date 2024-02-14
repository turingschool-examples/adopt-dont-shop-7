require "rails_helper"

RSpec.describe Application, type: :model do
  let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "in_progress")}

  let!(:shelter_1) {Shelter.create!(foster_program: true, name: "Adopters Unite", city: "Minneapolis", rank: 1 ) }

  let!(:pet_1) {shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Rover")}
  let!(:pet_2) {shelter_1.pets.create!(adoptable: true, age: 2, breed: "dalmatian", name: "Pongo")}

  let!(:application_pet_1) {ApplicationPet.create!(pet: pet_1, application: application_1)}
  let!(:application_pet_2) {ApplicationPet.create!(pet: pet_2, application: application_1)}

  describe "relationships" do
    it { should have_many(:pets).through(:application_pets) }
    it { should have_many(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should  validate_presence_of(:description) }
  end

  describe "instance methods" do
    it "submit reason for adoption" do
      expect(application_1.status).to eq("in_progress")

      application_1.submit_reason_for_adoption("the best reason")
      expect(application_1.status).to eq("pending")
    end
  end

  describe "#can_approve?" do
    it "returns true if all pet_status are 'approved'" do
      application_pet_1.approve
      application_pet_2.approve
      expect(application_1.can_approve?).to eq(true)
    end

    it "returns false if all pet_status are 'approved'" do
      application_pet_1.approve
      application_pet_2.reject
      expect(application_1.can_approve?).to eq(false)
    end
  end

  describe "#approve" do
    it "changes the status of application to 'approved' and update the adoptable to false" do
      application_1.approve

      expect(application_1.status).to eq("approved")
      expect(pet_1.reload.adoptable).to eq(false)
      expect(pet_2.reload.adoptable).to eq(false)

    end
  end

  describe "#can_reject?" do
    it "returns true if any of the pet_status are 'rejected'" do
      application_pet_1.approve
      application_pet_2.reject
      expect(application_1.can_reject?).to eq(true)
    end
  end

  describe "#reject" do
    it "changes the application status to 'rejected'" do
      application_1.reject
      expect(application_1.status).to eq("rejected")
    end
  end
end
