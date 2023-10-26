require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_length_of(:zip_code) }
  end

  describe '#full_address' do
    it 'can make an address' do
      application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "In Progress")
      expect(application.full_address).to eq("376 Amherst Street, Providence, RI 02904")
    end
  end

  describe '#add_pet' do
    it 'can add pets to an application' do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5)
      application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "In Progress")

      expect(application.application_pets).to eq([])

      application.add_pet(pet_1)

      expect(application.pets.count).to eq(1)
      expect(application.pets.first).to eq(pet_1)
    end
  end

  describe '#has_rejected_pets' do
    it 'will check if the application has rejected pets' do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Rejected")
      application.add_pet(pet_1)
      application_pets = ApplicationPet.create!(pet_id: pet_1.id, application_id: application.id, application_pet_status: 3)
      expect(application.has_rejected_pets).to eq(true)
    end
  end
end