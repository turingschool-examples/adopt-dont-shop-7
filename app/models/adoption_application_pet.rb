class AdoptionApplicationPet < ApplicationRecord
   belongs_to :adoption_application
   belongs_to :pet 
end