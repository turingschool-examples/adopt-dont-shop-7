class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def application_pet_status(application_id)
    application_pets.find_by(application_id: application_id).status
  end

  def self.adoptable
    where(adoptable: true)
  end
end
