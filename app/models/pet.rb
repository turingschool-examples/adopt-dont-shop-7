class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def find_app_relationship(application_id)
    ApplicationPet.where("pet_id = ? AND application_id = ?", id, application_id).first
  end
end
