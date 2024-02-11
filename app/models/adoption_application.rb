class AdoptionApplication < ApplicationRecord
   has_many :adoption_application_pets
   has_many :pets, through: :adoption_application_pets
   
   validates :name, :street_address, :city, :state, :zip_code, :description, :status, presence: true

   def add_pet_to_app(pet_id)
      pet = Pet.find(pet_id)
      self.pets << pet
   end

   
   #change adoptable? field on pet and application status
   def approve_pet
      self.pets.each do |pet|
         pet.update
      end
      redirect_to "/admin/applications/#{@application.id}"
   end
end
