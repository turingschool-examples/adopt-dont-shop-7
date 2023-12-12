class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def set_adoptable_false
    self.adoptable = false
    self.save
  end
  def self.adoptable
    where(adoptable: true)
  end

  def application_pet_approved(id)
    ApplicationPet.where(pet_id: self.id, application_id: id).pluck(:application_approved).first
  end
end
