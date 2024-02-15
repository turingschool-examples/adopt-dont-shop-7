class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  
  belongs_to :shelter
  has_many  :application_pets
  has_many  :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(name)
    where("name ILIKE ?", "%#{name}%" )
  end

  def is_approved?
    application_pets.where(pet_status: "approved").any?
  end
end
