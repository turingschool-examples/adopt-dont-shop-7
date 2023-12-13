class ApplicationPet < ApplicationRecord
  validates :application_id, presence: true
  validates :pet_id, presence: true

  belongs_to :application
  belongs_to :pet

  # Use this class method to find the application with a matching application_id and pet_id
  def self.find_application_pet(application_id, pet_id)
    ApplicationPet.where("application_id = ? AND pet_id = ?", application_id, pet_id)
  end
end
