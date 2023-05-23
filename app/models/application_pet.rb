class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.find_application_pet(pet_id, application_id)
    find_by(pet_id: pet_id, application_id: application_id)
  end
end