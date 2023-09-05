class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  validates :breed, presence: true
  validates :adoptable, inclusion: [true, false]
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def pets_status(application)
    pet_Application = PetApplication.where(pet_id: self.id, application_id: application.id).first.status
  end
end
