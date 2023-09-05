require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe 'instance methods' do
    describe '#approve' do
      it 'changes approval to true' do
        application2 = Application.create(applicant_name: "Benjamin Franklin", street_address: "456 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I like turkeys", status: "Pending")
        shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet1 = shelter1.pets.create(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
        application2.pets << pet1
        
        expect(application2.pet_applications.find_by(pet_id: pet1.id).approval).to be nil
        application2.pet_applications.find_by(pet_id: pet1.id).approve
        expect(application2.pet_applications.find_by(pet_id: pet1.id).approval).to be true
      end
    end
    
    describe '#reject' do
      it 'changes approval to false' do
        application2 = Application.create(applicant_name: "Benjamin Franklin", street_address: "456 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I like turkeys", status: "Pending")
        shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet1 = shelter1.pets.create(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
        application2.pets << pet1
        
        expect(application2.pet_applications.find_by(pet_id: pet1.id).approval).to be nil
        application2.pet_applications.find_by(pet_id: pet1.id).reject
        expect(application2.pet_applications.find_by(pet_id: pet1.id).approval).to be false
      end
    end
  end
end
