class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets, dependent: :destroy, source: :application

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def application_pet_approved(id)
    ApplicationPet.where(pet_id: self.id, application_id: id).pluck(:application_approved).first
  end

  def already_approved?
    adoptable ? false : true
  end
end
