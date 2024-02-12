class AdoptionApplication < ApplicationRecord
   has_many :adoption_application_pets
   has_many :pets, through: :adoption_application_pets

   
   # I removed the status from here, since we don't need to pass it anymore. 

   validates :name, :street_address, :city, :state, :zip_code, :description, presence: true

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

   # I commented this out because we are trying to not change the pet status for now
   
   #change adoptable? field on pet and application status
   # def approve_pet(pet_id)
   #    @pet_approved = Pet.find(pet_id)
   #    self.pets.each do |pet|
   #       if pet.id == @pet_approved.id
   #          pet.update(adoptable: false)
   #       end
   #    end
   # end

end