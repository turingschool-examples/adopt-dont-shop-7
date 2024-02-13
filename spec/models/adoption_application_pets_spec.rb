require 'rails_helper'

RSpec.describe AdoptionApplicationPet, type: :model do
   describe 'relationships' do
      it {should belong_to :adoption_application}
      it {should belong_to :pet}
   end

   describe 'validations' do
      it { should validate_presence_of :adoption_application_id }
      it { should validate_presence_of :pet_id }
   end

   describe '#change_app_pet_status' do
      it 'changes the adoption application pet status' do
         # setup
         # create shelter, create, pets, create, application, add pet to adoption application. 
         # then we use the join table to get the adoption application pet that is the one that we have the pet and the application with the same id

         shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
         pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
         pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
         mel_application = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs")
         mel_application.add_pet_to_app(pet_1.id)

         application_pet = AdoptionApplicationPet.where({pet_id: pet_1.id, adoption_application_id: mel_application.id}).first

         expect(application_pet.status).to eq(nil)

         application_pet.change_app_pet_status("Approved")

         expect(application_pet.reload.status).to eq("Approved")


      end
   end
end