class Pet < ApplicationRecord
  has_many :application_pets
  has_many :applications, through: :application_pets
  belongs_to :shelter
  
  validates :name, presence: true
  validates :age, presence: true, numericality: true

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def add_pet_to_application(pet_id)
    pet = Pet.find(pet_id)
    self.pets << pet
  end
end
