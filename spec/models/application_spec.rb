require "rails_helper"

RSpec.describe Application do
  describe 'associations' do  
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
    it {should have_many(:shelters).through(:pets)}
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

    describe '#has_pets?' do
      it 'returns true if an application has pets' do
        application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

        expect(application.has_pets?).to be false

        shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")
        applicatoin_pet = ApplicationPet.create!(application_id: application.id, pet_id: pet.id)

        expect(application.has_pets?).to be true
      end
    end

    describe '#in_progress?' do
      it 'returns true if an applications status in progress' do
        application_1 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

        expect(application_1.in_progress?).to be true

        application_2 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner", status: "Pending")

        expect(application_2.in_progress?).to be false
      end
    end

    describe '#pending?' do
      it 'returns true if an applications status is pending' do
        application_1 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

        expect(application_1.pending?).to be false

        application_2 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner", status: "Pending")

        expect(application_2.pending?).to be true
      end
    end

    describe '#approved?' do
      it 'returns true if an applications status is approved' do
        application_1 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

        expect(application_1.approved?).to be false

        application_2 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner", status: "Approved")

        expect(application_2.approved?).to be true
      end
    end

    describe '#rejected?' do
      it 'returns true if an applications status is rejected' do
        application_1 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

        expect(application_1.rejected?).to be false

        application_2 = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner", status: "Rejected")

        expect(application_2.rejected?).to be true
      end
    end
  end
end