require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
    it { should validate_presence_of :applicant_name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
  end

  describe 'instance methods' do
    describe '#update_status' do
      it 'US15 updates the status of an application to approved if all associated pet_applications are approved' do
        application2 = Application.create!(applicant_name: "Benjamin Franklin", street_address: "456 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I like turkeys", status: "Pending")
        shelter1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet1 = shelter1.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
        pet2 = shelter1.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)
        application2.pets << pet1
        application2.pets << pet2
        application2.pet_applications.find_by(pet_id: pet1.id).approve
        
        application2.update_status
        expect(application2.status).to eq("Pending")
        
        application2.pet_applications.find_by(pet_id: pet2.id).approve
        application2.reload

        expect(application2.status).to eq("Pending")
        application2.update_status

        expect(application2.status).to eq("Approved")
      end

      it 'US16 updates the status of an application to rejected if any associated pet_applications are rejected' do
        application2 = Application.create!(applicant_name: "Benjamin Franklin", street_address: "456 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I like turkeys", status: "Pending")
        shelter1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet1 = shelter1.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
        pet2 = shelter1.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)
        application2.pets << pet1
        application2.pets << pet2

        application2.pet_applications.find_by(pet_id: pet1.id).reject
        expect(application2.status).to eq("Pending")
        application2.update_status
        expect(application2.status).to eq("Rejected")
      end 
    end
  end
end
