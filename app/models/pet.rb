class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def pa_status(app_id)
    pet_application = PetApplication.find_by(pet_id: id, application_id: app_id)
    pet_application.pet_app_status
  end
end
