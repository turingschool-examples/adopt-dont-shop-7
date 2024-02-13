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

  def self.find_pet(pet)
    Pet.where("name ILIKE ?", "%#{pet}%")
  end

  def choice_made(application)
    ApplicationPet.find_by(pet: self, application: application).status?
  end

  def status(application)
    ApplicationPet.find_by(pet: self, application: application).status
  end


end
