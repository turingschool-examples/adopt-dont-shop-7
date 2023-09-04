require "rails_helper"

RSpec.describe Applicant, type: :model do
  describe "relationships" do
    it { should have_many(:applicants_pets) }
    it { should have_many(:pets).through(:applicants_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    # it { should validate_presence_of(:description) }
    it { should validate_presence_of(:application_status) }
  end

  describe "instance methods" do
    it "#descript" do
      applicant = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")
      shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = applicant.pets.create!(adoptable: true, age: 2, breed: "Dog", name: "Rex", shelter_id: shelter.id)

      query = applicant.descript

      expect(query).to eq(true)
    end
  end

end