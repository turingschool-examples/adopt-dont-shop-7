class AdoptionAppPet < ApplicationRecord
  belongs_to :adoption_app
  belongs_to :pet
end