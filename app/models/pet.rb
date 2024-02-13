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

  def find_application_pets(application_id)
    ApplicationPet.where("application_pets.application_id = #{application_id} AND application_pets.pet_id = #{self.id}").first
  end
end
