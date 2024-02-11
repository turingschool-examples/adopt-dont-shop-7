require 'rails_helper'

RSpec.describe AdoptionApplication, type: :model do
   describe 'relationships' do
      it { should have_many :adoption_application_pets }
      it { should have_many(:pets).through(:adoption_application_pets) }
   end

   describe 'validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:street_address) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zip_code) }
      it { should validate_presence_of(:description) }
   end

   describe '#add_pet_to_app' do
      it 'adds the pet to the adoption application' do
         shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
         pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
         pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
         application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")
   
         expect(application.add_pet_to_app(pet_1.id).first).to eq(pet_1)
      end
   end

   describe '#change_app_status' do
   it 'adds the pet to the adoption application' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
      application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")

      expect(application.status).to eq("In Progress")

      application.change_app_status("Pending")

      expect(application.status).to eq("Pending")
   end
end
end