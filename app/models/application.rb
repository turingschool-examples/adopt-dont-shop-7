class Application < ApplicationRecord 
  validates :street_address, :city, :state, :zip_code, :description, :pet_description, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def pet_app_find(pet_id)
    application_pets.where(pet_id: pet_id).first
  end
  
  def self.pending_shelters_application
      @applications = Application.where(status: "Pending")
  end
end