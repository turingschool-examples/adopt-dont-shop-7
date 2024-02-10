require "rails_helper"

RSpec.describe Application do
  describe 'associations' do  
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip_code)}
    it {should validate_presence_of(:endorsement)}
  end

  describe 'instance methods' do
    describe '#find_pets' do
      it 'returns pets associated with the application' do
        application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
        shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")
        applicatoin_pet = ApplicationPet.create!(application_id: application.id, pet_id: pet.id)

        expect(application.find_pets).to eq([pet])
      end
    end
  end
end