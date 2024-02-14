class AdoptionApplicationPet < ApplicationRecord
   belongs_to :adoption_application
   belongs_to :pet 

   validates :adoption_application_id, presence: true
   validates :pet_id, presence: true
   
   def change_app_pet_status(new_status)
      self.update_column(:status, new_status)
   end

   def self.change_status_to_approved(application_id, pet_id)
      adoption_app_pet = where({pet_id: pet_id,adoption_application_id: application_id}).first
      adoption_app_pet.change_app_pet_status("Approved")
   end

   def self.change_status_to_rejected(application_id, pet_id)
      adoption_app_pet = AdoptionApplicationPet.where({pet_id: pet_id,adoption_application_id: application_id}).first
      adoption_app_pet.change_app_pet_status("Rejected")
   end
end