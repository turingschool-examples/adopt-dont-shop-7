class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.search(pet_id, application_id)
    PetApplication.where(pet_id: pet_id, application_id: application_id)
  end
end