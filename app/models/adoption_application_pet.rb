class AdoptionApplicationPet < ApplicationRecord
   belongs_to :adoption_application
   belongs_to :pet 

   validates :adoption_application_id, presence: true
   validates :pet_id, presence: true
   
   def change_app_pet_status(new_status)
      self.update_column(:status, new_status)
   end
end