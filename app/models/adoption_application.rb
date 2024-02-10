class AdoptionApplication < ApplicationRecord
   has_many :adoption_application_pets
   has_many :pets, through: :adoption_application_pets
   # belongs_to :shelter
   
   validates :name, :street_address, :city, :state, :zip_code, :description, :status, presence: true

   def add_pet_to_app(pet_id)
      pet = Pet.find(pet_id)
      self.pets << pet
   end
end