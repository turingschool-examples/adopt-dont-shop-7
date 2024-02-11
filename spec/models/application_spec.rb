require "rails_helper"

RSpec.describe Application do
  describe "relationships" do
    it { should have_many(:pets) }
  end
  
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street_address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip_code}
    it { should validate_presence_of :description}
  end

  describe 'change_application_status' do
    describe 'application status' do
      it 'changes application status' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
        pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        # require 'pry'; binding.pry
        expect(applicant.status).to eq("In Progress")

        applicant.change_application_status("Pending")

        expect(applicant.status).to eq("Pending")

      end
    end
  end
end
