class AdoptionApplicationPet < ApplicationRecord
   belongs_to :adoption_application
   belongs_to :pet 

   # this change the adoption app pet status so we don't have to change the pet adoptable status and be within user story 14
   def change_app_pet_status(new_status)
      self.update_column(:status, new_status)
   end
end