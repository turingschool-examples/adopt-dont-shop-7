class AdoptionApplication < ApplicationRecord
   has_many :adoption_application_pets
   has_many :pets, through: :adoption_application_pets

   validates :name, presence: true 
   validates :street_address, presence: true
   validates :city, presence: true 
   validates :state, presence: true 
   validates :zip_code, presence: true, numericality: true
   validates :description, presence: true

   def add_pet_to_app(pet_id)
      pet = Pet.find(pet_id)
      self.pets << pet
   end

   # admin
   def change_app_status(new_status)
      self.update(status: new_status)
   end

   def add_ownership_description_to_app(description)
      self.update(ownership_description: description)
   end
end